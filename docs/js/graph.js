/* Would like to credit D3 Tip and Tricks by Malcom Maclean for example code on how to write a line graph.  */

$(document).ready(function()
{
  d3.json("data/date-posts-frequency.json", main);
  function main(error,data) {
    if (error) { alert(error);}

    var width = 700;
    var height = 500;

    var margin = 50;

    var x_axis = d3.scaleTime().range([margin,width - margin]);
    var y_axis = d3.scaleLinear().range([height,margin]);

    var line = d3.line()
    .x(function(d) { return x_axis(d.date); })
    .y(function(d) { return y_axis(d.count); });

    var svg = d3.select("#svg").append("svg")
    .attr("width",width + 100)
    .attr("height", height + 100)
    .append("g");

    function getDate(d)
    {
      return d.date;
    }

    function getCount(d)
    {
      return d.count;
    }

    function last_thirty_days(data,draw)
    {
      var last_thirty = [];

      for(i=0;i < 30;i++)
      {
        var d = data[data.length - 30 + i];
        last_thirty.push({date: new Date(d[0]),count: d[1]});
      }

      draw(last_thirty,"Last Thirty Day");
    }

    function count_months(days,data)
    {
      var months = [];
      getMonth = moment.months();
      for(i=0;i < (days);i++)
      {
        var d = data[data.length - days + i];
        var date = moment(new Date(d[0]));
        var current_month = date.month();
        var year = date.year();
        var full_date = new Date(getMonth[current_month] + " 1, " + year);
        if (months.length == 0)
        {
          months.push({date: full_date, count: d[1]});
        }
        else
        {
          var last = months[months.length - 1];
          if (moment(last.date).month() == current_month)
          {
            last.count += d[1];
          }
          else
          {
            months.push({date: full_date, count: d[1]});
          }

        }
      }
      return months;
    }

    function last_twelve_months(data,draw)
    {

      if (data.length < 365)
      {
        var days = data.length;
      }
      else
      {
        var days = 365;
      }
      var last_12_months = count_months(days,data);
      draw(last_12_months,"Last Twelve Months");
    }

    function every_month(data,draw)
    {
      var all_months = count_months(data.length,data);
      draw(all_months,"Every Month");
    }

    function initial_draw(data)
    {
      x_axis.domain(d3.extent(data,getDate));
      y_axis.domain([0,d3.max(data,getCount)]);

      svg.append("path")
      .data([data])
      .attr("class","line")
      .attr("d",line);

      var bottom = d3.axisBottom(x_axis)
      .tickSize(-width);
      
      svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(bottom)
      .attr("class", "x_axis")
      .selectAll("text")
      .attr("x","0.9em")
      .attr("y","1em")
      .attr("dy","0.35em");

      svg.append("g")
      .attr("transform", "translate(50,0)")
      .call(d3.axisLeft(y_axis))
      .attr("class", "y_axis");

      svg.append("text")
      .text("Last Thirty Days")
      .attr("class", "title")
      .attr("x",width / 2 - 50)
      .attr("y",50);
    }

    function update_draw(data,title)
    {
      y_axis.domain(
        [0, d3.max(data,getCount)]
      );

      x_axis.domain(d3.extent(data,getDate));

      svg = d3.select("#svg").transition();

      svg.select(".line")
      .duration(500)
      .attr("d",line(data));

      svg.select(".x_axis")
      .selectAll("text")
      .attr("dy","1.5em")
      .attr("transform", null);

      svg.select(".x_axis")
      .duration(500)
      .call(d3.axisBottom(x_axis));

      svg.select(".y_axis")
      .duration(500)
      .call(d3.axisLeft(y_axis));

      svg.select(".title")
      .duration(500)
      .text(title);
    }

    last_thirty_days(data,initial_draw);

    $("#last30").click(function()
    {
      last_thirty_days(data,update_draw);
    });

    $("#last12months").click(function()
    {
      last_twelve_months(data,update_draw)
    });

    $("#everymonth").click(function()
    {
      every_month(data,update_draw);
    });
  }
});

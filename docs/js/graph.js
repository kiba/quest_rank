/* Would like to credit D3 Tip and Tricks by Malcom Maclean for example code on how to write a line graph.  */

$(document).ready(function()
{
  var width = 700;
  var height = 500;

  margin = 50;

  var x_axis = d3.scaleTime().range([margin,width - margin]);
  var y_axis = d3.scaleLinear().range([height,margin]);

  var line = d3.line()
  .x(function(d) { return x_axis(d.date); })
  .y(function(d) { return y_axis(d.count); });

  var svg = d3.select("#svg").append("svg")
  .attr("width",width + 100)
  .attr("height", height + 100)
  .append("g");


  function last_thirty_chart () {
    d3.json("date-posts-frequency.json", function (error,data) {
      if (error) { alert(error);}

      var last_thirty = [];

      for(i=0;i < 30;i++)
      {
        var d = data[data.length - 30 + i];
        last_thirty.push({date: new Date(d[0]),count: d[1]});
      }

      x_axis.domain(d3.extent(last_thirty,function(d)
        {
          return d.date;
        }
      ));
      y_axis.domain(
        [0, d3.max(last_thirty,function(d) {return d.count;})]
      );

      svg.append("path")
      .data([last_thirty])
      .attr("class","line")
      .attr("d",line);

      svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x_axis))
      .selectAll("text")
      .attr("x","0.9em")
      .attr("y","1em")
      .attr("dy","0.35em")
      .attr("transform", "rotate(60)");

      svg.append("g")
      .attr("transform", "translate(50,0)")
      .call(d3.axisLeft(y_axis));

      svg.append("text")
      .text("Last Thirty Days")
      .attr("x",width / 2 - 50)
      .attr("y",50);
    });
  }

  function last_12_months_chart()
  {
    d3.json("date-posts-frequency.json", function (error,data) {
      if (error) { alert(error);}
      var last_12_months = [];
      if (data.length < 365)
      {
        var days = data.length;
      }
      else
      {
        var days = 365;
      }

      var months = moment.months()
      for(i=0;i < (days);i++)
      {
        var d = data[data.length - days + i];
        var date = moment(new Date(d[0]));
        var current_month = date.month();
        var year = date.year();
        var full_date = new Date(months[current_month] + " 1, " + year);
        if (last_12_months.length == 0)
        {
          last_12_months.push({date: full_date, count: d[1]});
        }
        else
        {
          var last = last_12_months[last_12_months.length - 1];
          if (last.month == current_month)
          {
            last.count += d[1];
          }
          else
          {
            last_12_months.push({date: full_date, count: d[1]});
          }

        }

        y_axis.domain(
          [0, d3.max(last_12_months,function(d) {return d.count;})]
        );

      }
      last_12_months.forEach(function(d)
      {
        console.log(d);
      });
    });
  }

  function every_month_chart()
  {
    d3.json("date-posts-frequency.json", function (error,data) {
      if (error) { alert(error);}
    });
  }


  last_thirty_chart()

  $("#last30").click(function()
  {
    last_thirty_chart();
  });

  $("#last12months").click(function()
  {
    last_12_months_chart();
  });

  $("#everymonth").click(function()
  {
    every_month_chart();
  });
});

$(document).ready(function()
{
  var width = 500;
  var height = 500;

  margin = 20;

  var x_axis = d3.scaleTime().range([0,width - margin]);
  var y_axis = d3.scaleTime().range([height - margin,0]);

  var line = d3.line()
  .x(function(d) { return x_axis(d.date); })
  .y(function(d) { return y_axis(d.count); });

  var svg = d3.select("#svg").append("svg")
  .attr("width",width + 100)
  .attr("height", height + 100)
  .append("g");

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
    .call(d3.axisBottom(x_axis));

    svg.append("g")
    .call(d3.axisLeft(y_axis));
  /*
    last_thirty.forEach(function(obj){
      console.log(obj);
    });
  */
  });
});

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
    .attr("transform", "translate(50,0)")
    .call(d3.axisLeft(y_axis));

    svg.append("text")
    .text("check")
    .attr("x","30")
    .attr("y","30");

    last_thirty.forEach(function(obj){
      console.log(obj);
    });
  });
});

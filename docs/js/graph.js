var width = 900;
var height = 500;

var x_axis = d3.scaleTime().range([0,width]);
var y_axis = d3.scaleTime().range([height,0]);

var line = d3.line()
.x(function(d) { return x(d[0]);})
.y(function(d) { return y(d[1]);});

var svg = d3.select("body").append("svg")
.attr("width",width + 100)
.attr("height", height + 100)
.append("g");

d3.json("date-posts-frequency.json", function (error,data) {
  if (error) { alert(error);}
  for(i=0;i < 30;i++)
  {
    console.log(data[data.length - 31 + i]);
  }
});

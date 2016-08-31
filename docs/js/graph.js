var width = 900;
var height = 500;

var x_axis = d3.scaleTime().range([0,width]);
var y_axis = d3.scaleTime().range([height,0]);

var line = d3.line()
.x(function(d) { return x(d.date); })
.y(function(d) { return y(d.count); });

var svg = d3.select("body").append("svg")
.attr("width",width + 100)
.attr("height", height + 100)
.append("g");

d3.json("date-posts-frequency.json", function (error,data) {
  if (error) { alert(error);}

  var last_thirty = [];

  for(i=0;i < 30;i++)
  {
    var d = data[data.length - 30 + i];
    last_thirty.push({date: d[0],count: d[1]});
  }

  x_axis.domain(d3.extent(last_thirty,function(d){return d.date; }));

  last_thirty.forEach(function(obj){
    console.log(obj);
  });

});

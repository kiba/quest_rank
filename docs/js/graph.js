var width = 900;
var height = 500;

d3.json("date-posts-frequency.json", function (error,data) {
  if (error) { alert(error);}
  for(i=0;i < 30;i++)
  {
    console.log(data[data.length - 31 + i]);
  }
});

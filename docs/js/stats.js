function average (data, length)
{
  var count = 0;
  for(i=0;i < length;i++)
  {
    var d = data[data.length - length + i];
    count += d[1];
  }
  var average = count / length;
  return average;
}

function stats(error,data)
{
  if (error) { alert(error);}
  var thirty = Math.trunc(average(data,30));
  if (data.length >= 365)
  {
    var year_on_year = Math.trunc(average(data,365));
  }
  var lifetime = Math.trunc(average(data,data.length));
  $("ul").append("<li>Last Thirty Days Average: " + thirty + " replies.");
}

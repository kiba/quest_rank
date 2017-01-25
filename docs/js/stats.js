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
  $("ul").append("<li>Last Thirty Days Average: " + thirty + " replies.");
}

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

  var seven = Math.trunc(average(data,7));
  $("ul").append("<li>Last Seven Days Average : " + seven + " replies per day.");


  var thirty = Math.trunc(average(data,30));
  $("ul").append("<li>Last Thirty Days Average: " + thirty + " replies per day.");

  if (data.length >= 365)
  {
    var year_on_year = Math.trunc(average(data,365));
    $("ul").append("<li>Year on Year Average: " + year_on_year + " replies per day.");
  }
  var lifetime = Math.trunc(average(data,data.length));
  $("ul").append("<li>Lifetime Average: " + lifetime + " replies per day.");

}

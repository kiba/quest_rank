function thirty_days_average (data)
{
  var count = 0;
  for(i=0;i < 30;i++)
  {
    var d = data[data.length - 30 + i];
    count += d[1];
  }
  var average = count / 30;
  return average;
}

function stats(error,data)
{
  if (error) { alert(error);}
  console.log(thirty_days_average(data));
}

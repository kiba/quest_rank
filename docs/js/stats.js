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
  console.log(average(data,30));
}

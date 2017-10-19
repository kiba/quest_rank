function average (data, length)
{
  var count = 0;
  for(var i=0;i < length;i++)
  {
    var d = data[data.length - length + i];
    count += d[1];
  }
  var average = count / length;
  return average;
}

function record_days (data)
{
  var n = 0;
  var results = [];
  for (var i = 0; i < data.length; i++)
  {
    if (data[i][1] > n)
    {
      n = data[i][1];
      results.push(data[i]);
    }
  }
  return results;
}

function stats(error,data)
{
  if (error) { alert(error);}
  var ul = "ul#records";
  var records = record_days(data);
  for (var i = 0; i < records.length; i++)
  {
    var date = records[i][0];
    var count = records[i][1];
    $(ul).append("<li> On " + date + ": " + count + " replies.</li>");
  }
  ul = "ul#stats";
  var today = data[data.length - 1][1]
  $(ul).append("<li> Today's Count: " + today + " replies.</li>")

  var seven = Math.trunc(average(data,7));
  $(ul).append("<li>Last Seven Days Average : " + seven + " replies per day.</li>");


  var thirty = Math.trunc(average(data,30));
  $(ul).append("<li>Last Thirty Days Average: " + thirty + " replies per day.</li>");

  if (data.length >= 365)
  {
    var year_on_year = Math.trunc(average(data,365));
    $(ul).append("<li>Year on Year Average: " + year_on_year + " replies per day.</li>");
  }
  var lifetime = Math.trunc(average(data,data.length));
  $(ul).append("<li>Lifetime Average: " + lifetime + " replies per day.</li>");

}

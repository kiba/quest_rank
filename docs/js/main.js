$(document).ready(function()
{
  d3.json("data/date-posts-frequency.json", graphing);
  d3.json("data/quest.json",metadata);
});

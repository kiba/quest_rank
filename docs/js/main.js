$(document).ready(function()
{
  var id = document.location.pathname.split("/quests/")[1].split(".html")[0]
  var path = "/data/quests/" + id + "/"
  d3.json(path + "date-posts-frequency.json", graphing);
  d3.json(path + "date-posts-frequency.json", stats);
  d3.json(path + "quest.json",metadata);
});

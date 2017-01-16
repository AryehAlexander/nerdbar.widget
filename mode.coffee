command: "~/.kwm/scripts/screens"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='kwmmode'></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  color: #66d9ef
  font: 12px Hack
  left: 10px
  top: 7px
  width:850px
  height: 16px
  white-space: nowrap
  text-overflow: ellipsis
  overflow: ellipsis
"""

update: (output, domEl) ->

  values = output.split('@');

  file = "";
  screenhtml = "";
  mode = values[0];
  screens = values[1];
  wins = values[2];
  win = "";
  i = 0;
  console.log(mode)
  console.log(/bsp/.test(mode))
  

  screensegs = screens.split('(');

  for sseg in screensegs
    screensegs[i] = sseg.replace /^\s+|\s+$/g, ""
    i+=1;

  screensegs = (x for x in screensegs  when x != '')

  i = 0;

  #apply a proper number tag so that space change controls can be added
  for sseg in screensegs
    i+= 1;
    if sseg.slice(-1) == ")"
      screenhtml += "<span class='icon screen#{String(i)}'>&nbsp;&nbsp;&nbsp;</span>" ;
    else
      screenhtml += "<span class='icon white screen#{String(i)}'>&nbsp;&nbsp;&nbsp;</span>" ;
    $(".screen#{String(i)}").on 'click', => @run "/usr/local/bin/kwmc space -fExperimental screen#{String(i)}"

  #display the html string
  $(domEl).find('.kwmmode').html("<span class='tilingMode icon'></span><span class='tilingMode white'>#{mode} <span class='blue'> ⎢ </span></span>" + screenhtml)

  

  
  # cycle through KWM space modes by clicking on the mode icon or mode name
  if /bsp/.test(mode) == true
    console.log("in bsp")
    $(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t float"
  else if /float/.test(mode) == true
    $(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t monocle"
  else
    $(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t bsp"

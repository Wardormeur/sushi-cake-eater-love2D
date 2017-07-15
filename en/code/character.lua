player = {}
window = {}
function love.load()
  title = "The cake Lover!"
  love.window.setTitle(title)
  love.graphics.setBackgroundColor(135, 206, 250)
  window.height = 600
  window.width = 800
  love.window.setMode(window.width, window.height)
	player.image = love.graphics.newImage('assets/character.png')
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(player.image, 100, 100)
end

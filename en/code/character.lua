player = {}
function love.load()
  title = "The cake Lover!"
  love.window.setTitle(title)
  love.graphics.setBackgroundColor(135, 206, 250)
	player.image = love.graphics.newImage('assets/character.png')
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(player.image, 100, 100)
end

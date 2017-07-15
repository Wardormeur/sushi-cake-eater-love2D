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
  player.x = 0
  player.y = 0
  player.speed = 150
end

function love.update(dt)
  if love.keyboard.isDown("left") then
    player.x = player.x - (player.speed * dt);
  end
  if love.keyboard.isDown("right") then
    player.x = player.x + (player.speed * dt);
  end
  if love.keyboard.isDown("up") then
    player.y = player.y - (player.speed * dt);
  end
  if love.keyboard.isDown("down") then
    player.y = player.y + (player.speed * dt);
  end
end

function love.draw()
  love.graphics.draw(player.image, player.x, player.y)
end

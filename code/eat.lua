player = {}
cakes = {}
window = {}
function love.load()
  title = "The cake Lover!"
  love.window.setTitle(title)
  love.graphics.setBackgroundColor(135, 206, 250)
	player.image = love.graphics.newImage('code/assets/character.png')
  player.width, player.height = player.image:getDimensions()
  player.x = 0
  player.y = 0
  player.speed = 150
  window.height, window.width = love.window.getMode()
  cakes.maxSimultaneousCakes = 5
  cakes.types = {}
  cakes.types[0] = "birthday"
  cakes.images = {}
  cakes.images["birthday"] = love.graphics.newImage('code/assets/birthday.png')
  cakes.dimensions = {}
  cakes.dimensions["birthday"] = {}
  cakes.dimensions["birthday"].width, cakes.dimensions["birthday"].height = cakes.images["birthday"]:getDimensions()
  cakes.instances = {}
end

function love.update(dt)
  -- character movement
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
  -- cakes creation
  for i=(#cakes.instances) + 1, cakes.maxSimultaneousCakes do
    cakes.instances[i] = {}
    cakes.instances[i].x = window.width
    cakes.instances[i].y = math.random(0, window.height - 180)
    cakes.instances[i].speed = math.random(1, 150);
    cakes.instances[i].type = cakes.types[0]; 
  end
  -- cakes movement
  for i=#cakes.instances, 1, -1 do
    local lecake = cakes.instances[i]
    cakes.instances[i].x = lecake.x - dt * lecake.speed
    if player.x < lecake.x + cakes.dimensions[lecake.type].width and
       player.x + player.width > lecake.x and
       player.y < lecake.y + cakes.dimensions[lecake.type].height and
       player.height + player.y > lecake.y then
         table.remove(cakes.instances, i)
    end
  end

end

function love.draw()
  love.graphics.draw(player.image, player.x, player.y)
  for i=1, #cakes.instances do
    local lecake = cakes.instances[i]
    love.graphics.draw(cakes.images[lecake.type], lecake.x, lecake.y)
  end
end

player = {}
cakes = {}
window = {}
counter = {}
function love.load()
  title = "The cake Lover!"
  love.window.setTitle(title)
  love.graphics.setFont(love.graphics.newFont(25))
  love.graphics.setBackgroundColor(135, 206, 250)
	player.image = love.graphics.newImage('../code/assets/character.png')
  player.width, player.height = player.image:getDimensions()
  player.x = 0
  player.y = 0
  player.speed = 150
  window.height, window.width = love.window.getMode()
  cakes.maxSimultaneousCakes = 5
  cakes.types = {}
  cakes.types[0] = "birthday"
  cakes.images = {}
  cakes.images["birthday"] = love.graphics.newImage('../code/assets/birthday.png')
  cakes.dimensions = {}
  cakes.dimensions["birthday"] = {}
  cakes.dimensions["birthday"].width, cakes.dimensions["birthday"].height = cakes.images["birthday"]:getDimensions()
  cakes.instances = {}
  counter = 0
end

function love.update(dt)
  -- character movement
  if love.keyboard.isDown("left") and player.x > 0 then
    player.x = player.x - (player.speed * dt);
  end
  if love.keyboard.isDown("right") and player.x < window.width then
    player.x = player.x + (player.speed * dt);
  end
  if love.keyboard.isDown("up") and player.y > 0 then
    player.y = player.y - (player.speed * dt);
  end
  if love.keyboard.isDown("down") and player.y < window.height then
    player.y = player.y + (player.speed * dt);
  end
  -- destroy cakes when OOscope?
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
         counter = counter + 100
    end
  end

end

function love.draw()
  love.graphics.setPointSize(5)
  love.graphics.draw(player.image, player.x, player.y)

	love.graphics.points(player.x, player.y)
  for i=1, #cakes.instances do
    local lecake = cakes.instances[i]
    love.graphics.draw(cakes.images[lecake.type], lecake.x, lecake.y)
  end
  love.graphics.printf("Score: "..counter, 10, 10, 9999)
end

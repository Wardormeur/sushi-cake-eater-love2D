player = {}
cakes = {}
window = {}
counter = {}
function love.load()
  title = "The cake Lover!"
  love.window.setTitle(title)
  love.graphics.setFont(love.graphics.newFont(25))
  window.height = 600
  window.width = 800
  love.window.setMode(window.width, window.height)
  love.graphics.setBackgroundColor(135, 206, 250)
	player.image = love.graphics.newImage('en/code/assets/player.png')
  player.width, player.height = player.image:getDimensions()
  player.x = 0
  player.y = 0
  player.alive = 1
  player.speed = 150
  cakes.maxSimultaneousCakes = 5
  cakes.types = {}
  cakes.types[1] = "birthday"
  cakes.types[2] = "poisonous"
  cakes.images = {}
  cakes.images["birthday"] = love.graphics.newImage('en/code/assets/birthday.png')
  cakes.images["poisonous"] = love.graphics.newImage('en/code/assets/poisonous.png')
  cakes.dimensions = {}
  cakes.dimensions["birthday"] = {}
  cakes.dimensions["birthday"].width, cakes.dimensions["birthday"].height = cakes.images["birthday"]:getDimensions()
  cakes.dimensions["poisonous"] = {}
  cakes.dimensions["poisonous"].width, cakes.dimensions["poisonous"].height = cakes.images["poisonous"]:getDimensions()
  cakes.instances = {}
  counter = 0
end

function love.update(dt)
  if player.alive == 1 then
    -- character movement
    if love.keyboard.isDown("left") and player.x > 0 then
      player.x = player.x - (player.speed * dt);
    end
    if love.keyboard.isDown("right") and player.x < window.width - player.width then
      player.x = player.x + (player.speed * dt);
    end
    if love.keyboard.isDown("up") and player.y > 0 then
      player.y = player.y - (player.speed * dt);
    end
    if love.keyboard.isDown("down") and player.y < window.height - player.height then
      player.y = player.y + (player.speed * dt);
    end
    -- cakes creation
    for i=(#cakes.instances) + 1, cakes.maxSimultaneousCakes do
      cakes.instances[i] = {}
      cakes.instances[i].x = window.width
      cakes.instances[i].speed = math.random(1, 250);
      cakes.instances[i].type = cakes.types[math.random(1, #cakes.types)];
      cakes.instances[i].y = math.random(0, window.height - cakes.dimensions[cakes.instances[i].type].height)
    end
    -- cakes movement
    for i=#cakes.instances, 1, -1 do
      local lecake = cakes.instances[i]
      cakes.instances[i].x = lecake.x - dt * lecake.speed
      if player.x < lecake.x + cakes.dimensions[lecake.type].width and
         player.x + player.width > lecake.x and
         player.y < lecake.y + cakes.dimensions[lecake.type].height and
         player.height + player.y > lecake.y then
           if lecake.type == "birthday" then
             counter = counter + 100
             table.remove(cakes.instances, i)
           elseif lecake.type == "poisonous" then
             player.alive = 0
           end
      end
      if lecake.x <= 0 then
        table.remove(cakes.instances, i)
      end
    end
  end
end

function love.draw()
  love.graphics.draw(player.image, player.x, player.y)
  for i=1, #cakes.instances do
    local lecake = cakes.instances[i]
    love.graphics.draw(cakes.images[lecake.type], lecake.x, lecake.y)
  end
  if player.alive == 1 then
    love.graphics.printf("Score: "..counter, 10, 10, 9999)
  elseif player.alive == 0 then
    love.graphics.printf("GAME OVER", window.height/2, window.width/2, 9999)
    love.graphics.printf(counter.." points", (window.height/2) + 18, (window.width/2) + 18, 9999)
  end
end

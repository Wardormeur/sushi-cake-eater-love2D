window = {}
function love.load()
  title = "The cake Lover!"
  love.window.setTitle(title)
  love.graphics.setBackgroundColor(135, 206, 250)
  window.height = 600
  window.width = 800
  love.window.setMode(window.width, window.height)
end

function love.update(dt)

end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", 300, 300, 50)
end

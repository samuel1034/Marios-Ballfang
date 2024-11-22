-- main.lua

-- Configuración inicial
function love.load()
    -- Configuración de la ventana
    love.window.setMode(800, 600)
    love.window.setTitle("Mario's Adventure")

    -- Carga la imagen de Mario
    marioImage = love.graphics.newImage("Mario.png")

    -- Configuración de Mario
    mario = {
        x = 350,
        y = 500,  -- Ajusta la posición vertical para que Mario esté en la parte inferior
        width = marioImage:getWidth(),
        height = marioImage:getHeight(),
        speed = 300
    }

    -- Carga la imagen de la pelota
    ballImage = love.graphics.newImage("ball.png")

    -- Configuración de la pelota
    ball = {
        x = math.random(50, 750),
        y = 0,
        width = ballImage:getWidth(),
        height = ballImage:getHeight(),
        speed = 200
    }

    -- Puntuación inicial
    score = 0

    -- Fuente para el texto
    font = love.graphics.newFont(20)
end

-- Actualización del juego
function love.update(dt)
    -- Mover a Mario según la entrada del teclado
    if love.keyboard.isDown("right") then
        mario.x = mario.x + mario.speed * dt
    elseif love.keyboard.isDown("left") then
        mario.x = mario.x - mario.speed * dt
    end

    -- Mantiene a Mario dentro de los límites de la pantalla
    if mario.x < 0 then
        mario.x = 0
    elseif mario.x + mario.width > love.graphics.getWidth() then
        mario.x = love.graphics.getWidth() - mario.width
    end

    -- Mueve la pelota hacia abajo
    ball.y = ball.y + ball.speed * dt

    -- Verifica si la pelota ha sido atrapada por Mario
    if ball.y + ball.height > mario.y and ball.y < mario.y + mario.height and
       ball.x > mario.x and ball.x < mario.x + mario.width then
        -- Incrementa la puntuación
        score = score + 1
        -- Reinicia la posición de la pelota
        ball.x = math.random(50, 750)
        ball.y = 0
    end

    -- Verifica si la pelota ha llegado al fondo de la pantalla
    if ball.y > love.graphics.getHeight() then
        -- Reinicia la posición de la pelota
        ball.x = math.random(50, 750)
        ball.y = 0
    end
end

-- Dibujar en la pantalla
function love.draw()
    -- Dibujar a Mario
    love.graphics.draw(marioImage, mario.x, mario.y)

    -- Dibujar la pelota
    love.graphics.draw(ballImage, ball.x, ball.y)

    -- Dibujar la puntuación
    love.graphics.setFont(font)
    love.graphics.print("Score: " .. score, 10, 10)
end

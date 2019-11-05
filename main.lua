-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

local Grid = {}

local Tetros = {}

local currentTetros = {}
currentTetros.shapeId = 1
currentTetros.rotation = 1
currentTetros.posX = 0
currentTetros.posY = 0
currentTetros.vx = 0
currentTetros.vy = 0

function love.load()
  
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  initGrid()
  initTetros()

  currentTetros.shapeId = math.random( 1, #Tetros )
  currentTetros.rotation = math.random( 1, #Tetros[currentTetros.shapeId])
  currentTetros.posX = Grid.posX + (((Grid.column * Grid.cellSize) / 2) - (math.floor((#Tetros[currentTetros.shapeId][currentTetros.rotation][1]) / 2) * Grid.cellSize))
  print(currentTetros.posX)
  currentTetros.posY = 0
  
end

function love.update(dt)
    if currentTetros.posY <= ((Grid.line * Grid.cellSize) - (Grid.cellSize * math.floor( #Tetros[currentTetros.shapeId][currentTetros.rotation]))) then
        currentTetros.vy = currentTetros.vy  + dt * 2
        currentTetros.posY = math.floor( currentTetros.vy ) * Grid.cellSize
    end
    print(currentTetros.posY)
end

function love.draw()
    drawTetros()
    drawGrid()
end

function love.keypressed(key)
  if key == "space" then
    currentTetros.rotation = currentTetros.rotation + 1

    if currentTetros.rotation > #Tetros[currentTetros.shapeId] then
        currentTetros.rotation = 1
    end
  end

  if key == "return" then
    currentTetros.rotation = 1
    currentTetros.shapeId = currentTetros.shapeId + 1

    if currentTetros.shapeId > #Tetros then
        currentTetros.shapeId = 1
    end
  end

  if key == "left" and (currentTetros.posX > Grid.posX) then
    currentTetros.posX = currentTetros.posX - Grid.cellSize
  end

  if key == "right" and (currentTetros.posX < Grid.posX + (Grid.column * Grid.cellSize) - (#Tetros[currentTetros.shapeId][currentTetros.rotation][1] * Grid.cellSize)) then
    currentTetros.posX = currentTetros.posX + Grid.cellSize
  end
  
end

function initGrid()
    Grid.line = 20
    Grid.column = 10
    Grid.cellSize = screenHeight / Grid.line
    Grid.posX = (screenWidth / 2) - ((Grid.cellSize * Grid.column) / 2)    
    Grid.cells = {}

    for line = 1, Grid.line, 1
    do
        Grid.cells[line] = {}
        for column = 1, Grid.column, 1
        do
            Grid.cells[line][column] = 0
        end
    end

end

function drawGrid()
    for line = 1, #Grid.cells, 1
    do
        for column = 1, #Grid.cells[line], 1
        do
            if Grid.cells[line][column] == 0 then
                love.graphics.rectangle("line", Grid.posX + (Grid.cellSize * (column - 1)), (line - 1) * Grid.cellSize, Grid.cellSize, Grid.cellSize)
            end
        end
    end
end

function initTetros()
    Tetros[1] = 
    { 
        {
            {0,0,0,0},
            {0,0,0,0},
            {1,1,1,1},
            {0,0,0,0}
        },
        {
            {0,0,1,0},
            {0,0,1,0},
            {0,0,1,0},
            {0,0,1,0}
        } 
    }

    Tetros[2] = 
    { 
        {
            {0,0,0,0},
            {0,1,1,0},
            {0,1,1,0},
            {0,0,0,0}
        }
    }

    Tetros[3] = 
    { 
        {
            {0,0,0},
            {1,1,1},
            {0,0,1},
        },
        {
            {0,1,0},
            {0,1,0},
            {1,1,0},
        },
        {
            {1,0,0},
            {1,1,1},
            {0,0,0},
        },
        {
            {0,1,1},
            {0,1,0},
            {0,1,0},
        } 
    }

    Tetros[4] = 
    { 
        {
            {0,0,0},
            {0,1,1},
            {1,1,0},
        },
        {
            {0,1,0},
            {0,1,1},
            {0,0,1},
        },
        {
            {0,0,0},
            {0,1,1},
            {1,1,0},
        },
        {
            {0,1,0},
            {0,1,1},
            {0,0,1},
        } 
    }
    Tetros[5] = 
    { 
        {
            {0,0,0},
            {0,1,1},
            {1,1,0},
        },
        {
            {0,1,0},
            {0,1,1},
            {0,0,1},
        }
    }
    Tetros[6] = 
    { 
        {
            {0,0,0},
            {1,1,1},
            {0,1,0},
        },
        {
            {0,1,0},
            {1,1,0},
            {0,1,0},
        },
        {
            {0,1,0},
            {1,1,1},
            {0,0,0},
        },
        {
            {0,1,0},
            {0,1,1},
            {0,1,0},
        } 
    }
    Tetros[7] = 
    { 
        {
            {0,0,0},
            {1,1,0},
            {0,1,1},
        },
        {
            {0,0,1},
            {0,1,1},
            {0,1,0},
        }
    }
end

function drawTetros()
    local shape = Tetros[currentTetros.shapeId][currentTetros.rotation]

    for line = 1, #shape, 1
    do
        for column =  1, #shape[line], 1
        do
            local x = currentTetros.posX + ((column - 1) * Grid.cellSize)
            local y = currentTetros.posY + ((line - 1) * Grid.cellSize)

            if shape[line][column] == 1 then
                love.graphics.rectangle("fill", x, y, Grid.cellSize, Grid.cellSize)
            end
        end
    end
end
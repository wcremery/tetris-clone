-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

local Grid = {}

local Tetros = {}

local tetrosIndex = 1
local tetrosRotation = 1


function initGrid()
    Grid.line = 20
    Grid.column = 10
    Grid.cellSize = screenWidth / Grid.line
    Grid.posX = (screenWidth / 2) - ((Grid.cellSize * Grid.column) / 2)
    print(posX)
    
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

function love.load()
  
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  initGrid()
  initTetros()
  
end

function love.update(dt)

end

function love.draw()
    local shape = Tetros[tetrosIndex][tetrosRotation]
    for line = 1, #shape, 1
    do
        for column =  1, #shape[line], 1
        do
            local x = line * 32
            local y = column * 32
            if shape[line][column] == 1 then
                love.graphics.rectangle("fill", x, y, 32, 32)
            else 
                love.graphics.rectangle("line", x, y, 32, 32)
            end
        end
    end
    
    drawGrid()

end

function love.keypressed(key)
  if key == "space" then
    tetrosRotation = tetrosRotation + 1
    if tetrosRotation > #Tetros[tetrosIndex] then
        tetrosRotation = 1
    end
  end

  if key == "return" then
    tetrosRotation = 1
    tetrosIndex = tetrosIndex + 1
    if tetrosIndex > #Tetros then
        tetrosIndex = 1
    end
  end
  
end
  
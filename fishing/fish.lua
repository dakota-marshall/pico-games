fish = {
    sprite = 20,
    swim_rate = 0.65,
    swim_direction = true,
    upper_bound = 96,
    lower_bound = 24,
    xpos = 40,
    ypos = 120,
    collided = false,
    collider = collider:new({
        xpos,
        ypos,
        8,
        8
    }),

    new=function(self,table)
        table = table or {}
        setmetatable(table, {__index=self})
        return table
    end,
    draw=function(self)
        -- self.collider:draw()
        spr(self.sprite, self.xpos, self.ypos, 
            1, 1, self.swim_direction
        )
    end,
    update=function(self)
        if grav_direction then
            self.ypos += gravity
        else
            self.ypos -= gravity
        end

        -- switch direction if hits edge
        if self.xpos >= self.upper_bound then
            self.swim_direction = false
        end
        if self.xpos <= self.lower_bound then
            self.swim_direction = true
        end

        -- increment swim direction
        if self.swim_direction == true then
            self.xpos += self.swim_rate
        else 
            self.xpos -= self.swim_rate
        end

        -- Update collider
        self.collider:update(self.xpos, self.ypos)

        -- Check if colliding with player
        if test_collision(
            self.collider, 
            player.collider
        ) then
            self.collided = true
        end
    end
}

function create_fish()
    local xpos = rnd(72) + 24
    local ypos = 140
    local direction = true
    if rnd(1) > 0.5 then
        direction = false
    end 

    add(fishes,
        fish:new({
            xpos=xpos,  
            ypos=ypos,
            swim_direction=direction,
            collider=collider:new({
                x=xpos,
                y=ypos,
                width=8,
                height=8
            })
        })
    )
end


function draw_fish()
    for fish in all(fishes) do 
        if (fish.ypos > -10 and
            fish.ypos < 140) then
            fish:draw()
        end
    end
end
function update_fish()
    for fish in all(fishes) do
        fish:update()

        if fish.collided then
            del(fishes, fish)
        end
    end
end

-- TODO:
-- reel in mode
-- background decoration
-- bubble sprite
-- more fish types

base_gravity = -1
gravity = -1
grav_direction = true

collider = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,

    new=function(self,table)
        table = table or {}
        setmetatable(table, {__index=self})
        return table
    end,
    update=function(self,newx,newy)
        self.x = newx
        self.y = newy
    end,
    draw=function(self)
        rect(
            self.x, 
            self.y,
            self.x+self.width,
            self.y+self.height,
            8
        )
    end
}

function _init()

    ticker = 0

    depth = 0
    
    mapy = 0
    map_speed = 1
    
    tiles = {
        water=1,
    }
    player = {
        sprite = 16,
        rate = 2,
        xpos = 64,
        ypos = 44,
        collider = collider:new({
            x=64,
            y=44,
            width=8,
            height=8
        }),
        draw=function(self)
            -- player.collider:draw()
            spr(player.sprite, 
                player.xpos, 
                player.ypos
            )

            for i=1,6 do
                spr(48, 
                    player.xpos, 
                    player.ypos-(i*8)
                )
            end
        end
    }
    fishes = {}

end

function _update()

    if grav_direction then
        mapy += gravity
        if mapy < -127 then
            mapy = 0
        end
    else
        mapy -= gravity
        if mapy > 127 then
            mapy = 0
        end
    end

    ticker += 1

    if (ticker % 10) == 0 then
        depth -= gravity
    end

    if speed_up then
        gravity = base_gravity - 1
    end
    if not speed_up then
        gravity = base_gravity
    end

    if rnd(1) > 0.5 and (ticker % 10) == 0 then
        create_fish()
    end

    entity_updater()
end

function _draw()
    cls()
    map(0, 0, 0, mapy, 16, 16)
    map(0, 0, 0, 128+mapy, 16, 16)
    map(0, 0, 0, -128+mapy, 16, 16)
    player:draw()

    print(depth)

    draw_fish()

end

function entity_updater()
    player_controller()    
    update_fish()
end

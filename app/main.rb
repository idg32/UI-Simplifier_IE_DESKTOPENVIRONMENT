module Window_Target
    def Window_Target.margin_target_window window
        set = window
        return [set[0],set[1],set[2],set[3]]
    end

    def Window_Target.margin_target_w_margins_window window
        set = window
        return [set[0] + 40,set[1] +40,set[2] - 80,set[3] - 80]
    end

    def Window_Target.re_eval_target_window (window, l_r_u_d)
        set = window
        if l_r_u_d == "l" 
            return [set[0]-30,set[1],70,set[3]]
        end
        if l_r_u_d == "r" 
            return [set[0] + set[2] - 30,set[1],70,720]
        end
        if l_r_u_d == "u" 
            return [set[0],set[3] -30,set[2],70]
        end
        if l_r_u_d == "d" 
            return [set[0],30,set[2],70]
        end
    end

    def Window_Target.calculate_drop_down_marginals (xv, yv, wv, hv, string_box, sprite, plc, h_v)
       # puts(h_v)
        if h_v == "v"
            sets = [xv,yv - (hv * plc), wv, hv, sprite]
        end
        return sets
    end

    def Window_Target.border_exp_target_windows window
        return nil
    end
end

class WINDOW_TARGET_CL
    attr_gtk
    attr_accessor :x_win, :y_win, :w_win, :h_win, :newy, :target_focus, :target_window, :toggle_window, :target_environemnt
    attr_accessor :f_height, :f_width, :f_loc_x, :f_loc_y, :file_butthole, :dpm_height, :dpm_width, :dpm_loc_x, :dpm_loc_y, :drop_menu
    attr_accessor :new_x, :new_y, :new_h, :new_w, :new_button, :number_of_elements, :element_lable, :margins, :menu_focus
    def tick
        define_default_value()
        input()
        display()
    end

    def define_default_value
        @x_win ||= 0
        @y_win ||= 0
        @w_win ||= 1280
        @h_win ||= 720
        @margins ||= [4,2]
        @element_lable ||= [[]]
        args.state.labels_name ||= ["NEW FILE","NEW WINDOW","CLOSE FILE","EXIT APP"]
        args.state.string_size ||= [args.gtk.calcstringbox(args.state.labels_name[0], 0),args.gtk.calcstringbox(args.state.labels_name[1], 0)]
        contents_container()
        file_button_defaults()
        drop_menu_defaults()
        @newy  ||= false
        @target_focus ||= nil
        @menu_focus ||= nil
        @target_window ||= [@x_win,@y_win,@w_win,@h_win,'sprites/GUI/layer_1.png']
        @target_environemnt ||= [@x_win,@y_win,@w_win,@h_win,'sprites/GUI/layer_2.png']
        @toggle_window ||= false
    end

    def contents_container
        @number_of_elements = 2
    end

    def drop_menu_defaults
        @dpm_loc_x ||= @file_butthole[0]
        @dpm_loc_y ||= @file_butthole[1] - @new_button[0][3]
        @dpm_width ||= @new_button[0][2] + @margins[0]
        @dpm_height ||= args.state.string_size[1][1]
        @drop_menu ||= []
        @drop_menu[0] ||= Window_Target.calculate_drop_down_marginals(@dpm_loc_x, @dpm_loc_y, @dpm_width, @dpm_height,args.state.string_size,'sprites/GUI/drop_menu.png',0,"v")
        @drop_menu[1] ||= Window_Target.calculate_drop_down_marginals(@dpm_loc_x, @dpm_loc_y, @dpm_width, @dpm_height,args.state.string_size,'sprites/GUI/drop_menu.png',1,"v")
        #hv, hy, xv, yv, string_box, sprite, plc, h_v
        @drop_menu[2] ||= Window_Target.calculate_drop_down_marginals(@dpm_loc_x, @dpm_loc_y, @dpm_width, @dpm_height,args.state.string_size,'sprites/GUI/drop_menu.png',2,"v")
        @drop_menu[3] ||= Window_Target.calculate_drop_down_marginals(@dpm_loc_x, @dpm_loc_y, @dpm_width, @dpm_height,args.state.string_size,'sprites/GUI/drop_menu.png',3,"v")

    end

    def file_button_defaults
        @f_loc_x ||= 4
        @f_loc_y ||= 720 -2 - 25
        @f_width ||=  95
        @f_height ||= 25
        @element_lable[0] = [@f_loc_x + @f_width / 4, @f_loc_y + @f_height - @margins[0], "FILE"]
        @file_butthole = [@f_loc_x + @element_lable[0][0] / 2, @f_loc_y, @f_width - @element_lable[0][0], @f_height, 'sprites/GUI/container_pod.png']
        @new_x ||= 4 #+ args.state.string_size[0]
        @new_y ||= @file_butthole[1] - 41
        @new_w ||= args.state.string_size[1][0] + @margins[0]
        @new_h ||= args.state.string_size[0][1]
        title_to_menu_dropables(args.state.labels_name)

        # @element_lable[1] = [@new_x + (args.state.string_size[0][0] /11.2 + margins[0] * 3), @new_y + margins[1] * (args.state.string_size[0][1] - 2), args.state.labels_name[0]]
        # @element_lable[2] = [@new_x + (args.state.string_size[1][0] /11.2 + margins[0] * 3), @new_y + margins[1] * (args.state.string_size[1][1] - 2) - @new_h, args.state.labels_name[1]]
        # @element_lable[3] = [@new_x + (args.state.string_size[1][0] /11.2 + margins[0] * 3), @new_y + margins[1] * (args.state.string_size[1][1] - 2) - @new_h * 2, args.state.labels_name[2]]
        @new_button ||= []
        title_to_menu_ratios(args.state.labels_name)
        # @new_button[0] = [@f_loc_x + @element_lable[0][0] / 2, @new_y + 20.5, @new_w, @new_h, 'sprites/GUI/container_pod.png']
        # @new_button[1] = [@f_loc_x + @element_lable[0][0] / 2, @new_y, @new_w, @new_h, 'sprites/GUI/container_pod.png']
        # @new_button[2] = [@f_loc_x + @element_lable[0][0] / 2, @new_y - 22, @new_w, @new_h, 'sprites/GUI/container_pod.png']

    end

    def title_to_menu_ratios(values)
        for i in 0..values.size() do
            @new_button[i] = [@f_loc_x + @element_lable[0][0] / 2, @new_y + @margins[1] * (args.state.string_size[1][1] - 2) - (@new_h * (i + 1)), @new_w, @new_h, 'sprites/GUI/container_pod.png']
        end
    end

    def title_to_menu_dropables(values)
        for i in 0..values.size() do
            puts(i)
            if i != -1
                @element_lable[i+1] = [@new_x + (args.state.string_size[1][0] /11.2 + @margins[0] * 3), @new_y + @margins[1] * (args.state.string_size[1][1] - 2) - (@new_h * i), args.state.labels_name[i]]
            end
        end
    end

    def set_target_coords x,y
        @x_win = x
        @y_win = y
    end

    def input
        #this is for repositioning
        if inputs.mouse.inside_rect? Window_Target.margin_target_w_margins_window(@target_environemnt)
            @target_focus = @target_environemnt if @target_focus == nil && @newy == true && inputs.mouse.button_right
            @target_focus = nil if @target_focus != nil && @newy == true && !inputs.mouse.button_right
            if inputs.mouse.button_right && @target_focus == @target_environemnt
                @target_environemnt[0] = inputs.mouse.x - @target_environemnt[2] / 2
                @target_environemnt[1] = inputs.mouse.y - @target_environemnt[3] / 2
            end
        end
        #these are for resizing
        if inputs.mouse.inside_rect? Window_Target.re_eval_target_window(@target_environemnt, "l")
            if @newy == true && inputs.mouse.button_left && @target_focus == nil
                @target_environemnt[0] = inputs.mouse.x
                # @target_environemnt[2] = (@w_win - @target_environemnt[0]).clamp(40,1280) 
                @target_environemnt[2] = (@w_win - @target_environemnt[0]).clamp(40,1280) 
                outputs.labels << [200,200,"#{@target_environemnt}"]
            end
        end
        if inputs.mouse.inside_rect? Window_Target.re_eval_target_window(@target_environemnt, "r")
            if @newy == true && inputs.mouse.button_left && @target_focus == nil
                @target_environemnt[2] = (inputs.mouse.x - @target_environemnt[0]).clamp(40,1280) 
                @w_win = @target_environemnt[2]
                # @target_environemnt[0]  = @w_win - @target_environemnt[0]
                outputs.labels << [200,200,"#{@target_environemnt}"]
            end
        end
        if inputs.mouse.inside_rect? Window_Target.re_eval_target_window(@target_environemnt, "u")
            if @newy == true && inputs.mouse.button_left && @target_focus == nil
                @target_environemnt[3] = inputs.mouse.y
                @h_win = @target_environemnt[1]
                #@target_environemnt[2] = @w_win - @target_environemnt[0]
                outputs.labels << [200,200,"YES"]
            end
        end
        if inputs.mouse.inside_rect? Window_Target.re_eval_target_window(@target_environemnt, "d")
            if @newy == true && inputs.mouse.button_left && @target_focus == nil
                @target_environemnt[1] = inputs.mouse.y
                @target_environemnt[3] = @h_win - @target_environemnt[1]
                #@target_environemnt[2] = @w_win - @target_environemnt[0]
                outputs.labels << [200,200,"YES"]
            end
        end
        #these are for menus
        if inputs.mouse.inside_rect? Window_Target.margin_target_window(@drop_menu[0])
            if @target_focus != nil
                @menu_focus = @new_button[0]
                if (inputs.mouse.button_left)&& inputs.mouse.click 
                    @newy = true
                    @w_win = 1280
                    @h_win = 720
                    @target_environemnt = [@x_win,@y_win,@w_win,@h_win,'sprites/GUI/layer_2.png']
                    @target_focus = nil
                    @menu_focus = nil
                end
            end
        else
            @menu_focus = nil if @menu_focus == @drop_menu[0]
        end
        if inputs.mouse.inside_rect? Window_Target.margin_target_window(@drop_menu[3])
            if @target_focus != nil
                @menu_focus = @new_button[3]
                if (inputs.mouse.button_left)&& inputs.mouse.click 
                    gtk.request_quit
                end
            end
        else
            @menu_focus = nil if @menu_focus == @drop_menu[3]
        end
        if inputs.mouse.inside_rect? Window_Target.margin_target_window(@drop_menu[2])
            if @target_focus != nil
                @menu_focus = @new_button[2]
                if inputs.mouse.click && (inputs.mouse.button_left)
                    @newy = false
                    @target_focus = nil
                    @menu_focus = nil
                end
            end
        else
            @menu_focus = nil if @menu_focus == @drop_menu[2]
        end
        if inputs.mouse.inside_rect? Window_Target.margin_target_window(@drop_menu[1])
            if @target_focus != nil
                @menu_focus = @new_button[1]
                if inputs.mouse.click && (inputs.mouse.button_left)
                    @newy = false
                    @target_focus = nil
                    @menu_focus = nil
                end
            end
        else
            @menu_focus = nil if @menu_focus == @drop_menu[1]
        end
        if inputs.mouse.inside_rect? Window_Target.margin_target_window(@file_butthole)
           if (inputs.mouse.button_left)
                @target_focus = @drop_menu
                puts(@target_focus)
           end
           if (inputs.mouse.button_right)
                @target_focus = nil
                puts("OFF")
           end
       end
    end

    def display    
        outputs.sprites <<@target_window
        outputs.sprites << @target_environemnt if @newy
        outputs.sprites << @file_butthole
        outputs.labels  << @element_lable[0]
        outputs.labels  << @element_lable[1] if @target_focus == @drop_menu
        outputs.labels  << @element_lable[2] if @target_focus == @drop_menu
        outputs.labels  << @element_lable[3] if @target_focus == @drop_menu
        outputs.labels  << @element_lable[4] if @target_focus == @drop_menu
        outputs.sprites << @drop_menu[0] if @target_focus == @drop_menu
        outputs.sprites << @drop_menu[1] if @target_focus == @drop_menu
        outputs.sprites << @drop_menu[2] if @target_focus == @drop_menu
        outputs.sprites << @drop_menu[3] if @target_focus == @drop_menu

        outputs.sprites << @new_button[0] if @menu_focus == @new_button[0]
        outputs.sprites << @new_button[1] if @menu_focus == @new_button[1]
        outputs.sprites << @new_button[2] if @menu_focus == @new_button[2]
        outputs.sprites << @new_button[3] if @menu_focus == @new_button[3]



    end

    def at 
        return true
    end
end


$new_window = WINDOW_TARGET_CL.new

def tick args
    args.state.value_windows ||= [$new_window]
    args.state.variant_window_count = args.state.value_windows.size()
    args.state.value_windows[0].args = args
    args.state.value_windows[0].args.outputs = args.outputs
    args.state.value_windows[0].tick

end
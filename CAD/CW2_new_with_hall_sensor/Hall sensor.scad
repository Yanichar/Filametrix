$fn = 200;

module hall_sensor()
{
    import("../../STL/Hall_sensor_cutout.stl");  
}

module hole_eliminator()
{
    external_ring_dia = 10;
    internal_diameter = 2.4;
    depth = 8;
    
    rotate([90, 0, 0])
    {
        difference()
        {
            cylinder(h=depth, r1=external_ring_dia/2, r2=internal_diameter/2, center=false);
            translate([0, 0, -0.01]) cylinder(h=depth + 0.02, r=internal_diameter/2, center=false);
        }
    }
}

module magnet()
{
    magnet_dia = 6.2;
    magnet_h = 3.2;
    enter_path_length = 15;
    service_path_length = 2;
    
    hull()
    { 
        cylinder(h=magnet_h, r=magnet_dia/2, center=true);
        translate([enter_path_length, 0, 0]) cube([0.1, magnet_dia, magnet_h], center=true);
    }
    translate([-magnet_dia/2, 0, 0]) cube([service_path_length, 2, 2], center=true);
}

difference()
{
    union()
    {
        import("../../STL/CW2_new_motor_plate/SB_CW2_new_motor_plate_Main_Buddy_Cutting_with_ECAS_centered.stl");
        //translate([-1.11, 30.11, 8.2]) hole_eliminator();
    }
    translate([-1.05, 20, 0]) hall_sensor();
    translate([-1.05, 20, 12]) #magnet(); 
}



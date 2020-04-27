# Axes

proc axes*[F:SomeFloat,I:SomeInteger,FF:SomeFloat]( x_tick, y_tick, x_org, y_org:F, 
                                                    major_x, major_y:I, tick_size:FF) =
  ##[
  Draw X and Y coordinate axes with linearly and/or logarithmically spaced tick marks.

  Tick marks are positioned along each axis so that major tick marks fall on the axes origin (whether visible or not). Major tick marks are labeled with the corresponding data values. Axes are drawn according to the scale of the window. Axes and tick marks are drawn using solid lines; line color and width can be modified using the `gr_setlinetype` and `gr_setlinewidth` functions. Axes are drawn according to the linear or logarithmic transformation established by the `gr_setscale` function.

  Parameters:

  - `x_tick`: The interval between minor tick marks on the X axis.
  - `y_tick`: The interval between minor tick marks on the Y axis.
  - `x_org`: The world coordinate of the origin (point of intersection) of the X axis.
  - `y_org`: The world coordinate of the origin (point of intersection) of the Y axis.
  - `major_x`: Unitless integer value specifying the number of minor tick intervals between major tick marks on the X axis. Values of 0 or 1 imply no minor ticks. Negative values specify no labels will be drawn for the associated axis.
  - `major_y`: Unitless integer value specifying the number of minor tick intervals between major tick marks on the Y axis. Values of 0 or 1 imply no minor ticks. Negative values specify no labels will be drawn for the associated axis.
  - `tick_size`: The length of minor tick marks specified in a normalized device coordinate unit. Major tick marks are twice as long as minor tick marks. A negative value reverses the tick marks on the axes from inward facing to outward facing (or vice versa).
  ]##
  gr_axes( x_tick.cdouble, y_tick.cdouble, 
           x_org.cdouble, y_org.cdouble, 
           major_x.cint, major_y.cint, 
           tick_size.cdouble)  


proc axes*[F:SomeFloat,I:SomeInteger,FF:SomeFloat](x_tick, y_tick, z_tick, 
           x_org, y_org, z_org:F, 
           major_x, major_y, major_z:I, 
           tick_size:FF) =
  ##[
  Draw X, Y and Z coordinate axes with linearly and/or logarithmically spaced tick marks.

  Tick marks are positioned along each axis so that major tick marks fall on the axes origin (whether visible or not). Major tick marks are labeled with the corresponding data values. Axes are drawn according to the scale of the window. Axes and tick marks are drawn using solid lines; line color and width can be modified using the gr_setlinetype and gr_setlinewidth functions. Axes are drawn according to the linear or logarithmic transformation established by the gr_setscale function.

  Parameters:

  - `x_tick`: The length in world coordinates of the interval between minor grid lines in X direction.
  - `y_tick`: The length in world coordinates of the interval between minor grid lines in Y direction.
  - `z_tick`: The length in world coordinates of the interval between minor grid lines in Z direction.
  - `x_org`: The world coordinate of the origin (point of intersection) of the X axis.
  - `y_org`: The world coordinate of the origin (point of intersection) of the Y axis.
  - `z_org`: The world coordinate of the origin (point of intersection) of the Z axis.
  - `major_x`: Unitless integer value specifying the number of minor grid lines between major grid lines on the X axis. Values of 0 or 1 imply no grid lines.
  - `major_y`: Unitless integer value specifying the number of minor grid lines between major grid lines on the Y axis. Values of 0 or 1 imply no grid lines.
  - `major_z`: Unitless integer value specifying the number of minor grid lines between major grid lines on the Z axis. Values of 0 or 1 imply no grid lines.
  - `tick_size`: The length of minor tick marks specified in a normalized device coordinate unit. Major tick marks are twice as long as minor tick marks. A negative value reverses the tick marks on the axes from inward facing to outward facing (or vice versa).
  ]##
  gr_axes3d( x_tick.cdouble, y_tick.cdouble, z_tick.cdouble, 
             x_org.cdouble, y_org.cdouble, z_org.cdouble, 
             major_x.cint, major_y.cint, major_z.cint,
             tick_size.cdouble)  


proc axes*( origin:array[2,float],
            minor_ticks_spacing:array[2,float]=[1.0,0.0]; 
            major_nticks:array[2,int]=[0,1]; 
            tick_length:float=0.01 ) =
  ##[
  Draw X and Y coordinate axes with linearly and/or logarithmically spaced tick marks.
  
  There are two kind of ticks: minor ticks are just a tick in the axe and major ticks are
  twice as long ticks with a label.

  `minor_ticks_spacing` indicates the spacing between minor ticks in world coordinates. If 0.0, then that axe is not represented.
  
  `major_nticks` indicates how many minor ticks (minus one) there are for every major tick. 
  The values 0 or 1 means that there are no minor ticks.

  The `tick_length` indicates the minor tick's length (major ticks are twice as long) in
  NDC (Normalized Device Coordinate) units. Negative values reverses the tick mark on the axe.
  The value 0.0 is not valid

  `original documentation <https://gr-framework.org/c-gr.html#_CPPv47gr_axesddddiid>`_
  ]##
  axes( minor_ticks_spacing[0], minor_ticks_spacing[1],
           origin[0], origin[1], 
           major_nticks[0], major_nticks[1], 
           tick_length)



#proc gr_tick*(a:cdouble, b:cdouble):cdouble

proc tick*(min,max:float):float = 
  ## Calculates the spacing between ticks in order to have 5 minor ticks 
  # replaces gr_tick
  (max-min)/5.0


type
  ScaleType* = enum
    stX_LOG,  ## Logarithmic X-axis
    stY_LOG,  ## Logarithmic Y-axis
    stZ_LOG,  ## Logarithmic Z-axis
    stFLIP_X, ## Flip X-axis
    stFLIP_Y, ## Flip Y-axis
    stFLIP_Z  ## Flip Z-axis


proc setScale*(scale:ScaleType) =
  ##[
  Set the type of transformation to be used for subsequent GR output primitives.

  This function defines the current transformation according to the given scale specification which may be or’ed together using any of the above options. GR uses these options for all subsequent output primitives until another value is provided. The scale options are used to transform points from an abstract logarithmic or semi-logarithmic coordinate system, which may be flipped along each axis, into the world coordinate system.

  Note:

  When applying a logarithmic transformation to a specific axis, the system assumes that the axes limits are greater than zero.
  ]##
  discard gr_setscale(scale.cint)
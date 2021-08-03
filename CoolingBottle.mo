model CoolingBottle
  // Input Paramters
  parameter Modelica.Units.SI.Temperature T0Milk(displayUnit = "degC") = 363.15 "Initial Milk Temperture";
  parameter Modelica.Units.SI.Temperature T0Bottle(displayUnit = "degC") = 363.15 "Initial Bottle Temperture";
  parameter Modelica.Units.SI.Temperature TWater(displayUnit = "degC") = 288.15 "Water Temperture";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer HInterface = 33.7 "Heat transfer coef. from outer wall to water";
  parameter Modelica.Units.SI.ThermalConductance GBottle = 6.18 "Thermal Conductance of Bottle";
  parameter Modelica.Units.SI.HeatCapacity HCMilk = 336 "Milk Heat Capacity";
  parameter Modelica.Units.SI.HeatCapacity HCBottle = 75.4 "Bottle Heat Capacity";
  // Output Parameters
  output Modelica.Units.SI.Temperature T_milk(displayUnit = "degC") = milk.T "Milk Temperture";
  output Modelica.Units.SI.Temperature T_bottle(displayUnit = "degC") = heatCapacitor.T "Glass Temperture";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor milk(C = HCMilk, T(displayUnit = "K", fixed = false, start = T0Milk)) annotation(
    Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = HCBottle, T(displayUnit = "K", fixed = false, start = T0Bottle)) annotation(
    Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
    Placement(visible = true, transformation(origin = {42, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = HInterface)  annotation(
    Placement(visible = true, transformation(origin = {42, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(displayUnit = "K") = TWater) annotation(
    Placement(visible = true, transformation(origin = {82, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = GBottle) annotation(
    Placement(visible = true, transformation(origin = {-36, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(heatCapacitor.port, convection.solid) annotation(
    Line(points = {{-2, -10}, {32, -10}}, color = {191, 0, 0}));
  connect(convection.Gc, const1.y) annotation(
    Line(points = {{42, 0}, {42, 41}}, color = {0, 0, 127}));
  connect(fixedTemperature.port, convection.fluid) annotation(
    Line(points = {{72, -10}, {52, -10}}, color = {191, 0, 0}));
  connect(thermalConductor.port_b, heatCapacitor.port) annotation(
    Line(points = {{-26, -10}, {-2, -10}}, color = {191, 0, 0}));
  connect(milk.port, thermalConductor.port_a) annotation(
    Line(points = {{-78, -10}, {-46, -10}}, color = {191, 0, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1));
end CoolingBottle;

**Autor/a:** Cesar

```
```bash
<Window x:Class="EntregaInterfaces.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:EntregaInterfaces"
        mc:Ignorable="d"
        Title="LiveChat" Height="600" Width="800" ResizeMode="CanResize" WindowStartupLocation="CenterScreen">
    <!--Imagen de fondo-->
    <Window.Background>
        <ImageBrush ImageSource="/imgs/Fondo.png" Stretch="UniformToFill" AlignmentX="Center" AlignmentY="Center"/>
    </Window.Background>
    <!--Estilos-->
    <Window.Resources>
        <!--colores usados-->
        <SolidColorBrush x:Key="colorTarjeta" Color="#FFF2E3C6"/>
        <SolidColorBrush x:Key="colorBordeTarjeta" Color="#33AAAAAA"/>
        <SolidColorBrush x:Key="colorDivisor" Color="#26000000"/>
        <SolidColorBrush x:Key="colorNaranja" Color="#E86A33"/>
        <SolidColorBrush x:Key="colorTexto" Color="#000000"/>
        <SolidColorBrush x:Key="colorTextoSuave" Color="#99000000"/>

        <!--Estilo del titulo principal-->
        <Style x:Key="Estilo_del_titulo_grande" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="FontSize" Value="28"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
        </Style>

        <!--Estilo del titulo de la tarjeta-->
        <Style x:Key="Estilo_del_titulo_pequeño" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="FontSize" Value="20"/>
            <Setter Property="FontWeight" Value="Bold"/>
        </Style>
        
        <!--Estilo del texto suave-->
        <Style x:Key="Estilo_del_texto_suave" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTextoSuave}"/>
        </Style>

        <!--Estilo de la tarjeta-->
        <Style x:Key="Estilo_de_la_tarjeta" TargetType="Border">
            <Setter Property="Background" Value="{StaticResource colorTarjeta}"/>
            <Setter Property="BorderBrush" Value="{StaticResource colorBordeTarjeta}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius" Value="14"/>
            <Setter Property="Padding" Value="24"/>
            <Setter Property="Effect">
                <Setter.Value>
                    <DropShadowEffect Color="#6F6F6F" Opacity="0.35" BlurRadius="32" ShadowDepth="0"/>
                </Setter.Value>
            </Setter>
        </Style>

        <!--Estilo de la tarjeta de arriba-->
        <Style x:Key="Estilo_de_la_tarjeta_arriba" TargetType="Border">
            <Setter Property="Background" Value="{StaticResource colorTarjeta}"/>
            <Setter Property="BorderBrush" Value="{StaticResource colorBordeTarjeta}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius" Value="10"/>
            <Setter Property="Padding" Value="10.6"/>
            <Setter Property="Effect">
                <Setter.Value>
                    <DropShadowEffect Color="#6F6F6F" Opacity="0.30" BlurRadius="20" ShadowDepth="0"/>
                </Setter.Value>
            </Setter>
        </Style>

        <!--Estilo de las entradas de texto-->
        <Style x:Key="entradaTexto" TargetType="TextBox">
            <Setter Property="Height" Value="36"/>
            <Setter Property="Padding" Value="10.6"/>
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="Background" Value="#F7F7F7"/>
            <Setter Property="BorderBrush" Value="#2A2A2A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TextBox">
                        <Border Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}">
                            <ScrollViewer x:Name="PART_ContentHost"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!--Estilo de la entrada de contraseñas-->
        <Style x:Key="Contraseña" TargetType="PasswordBox">
            <Setter Property="Height" Value="36"/>
            <Setter Property="Padding" Value="10.6"/>
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="Background" Value="#F7F7F7"/>
            <Setter Property="BorderBrush" Value="#2A2A2A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="PasswordBox">
                        <Border Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}">
                            <ScrollViewer x:Name="PART_ContentHost"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!--Estilo de los botones-->
        <Style x:Key="boton" TargetType="Button">
            <Setter Property="Height" Value="44"/>
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="Background" Value="{StaticResource colorNaranja}"/>
            <Setter Property="BorderBrush" Value="{StaticResource colorNaranja}"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="fondo" CornerRadius="10"
                         Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="fondo" Property="Background" Value="#F28A4A"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="fondo" Property="Background" Value="#D86520"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="fondo" Property="Opacity" Value="0.6"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <!--Estilo de links-->
        <Style x:Key="link" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="TextDecorations" Value="Underline"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>

        <!--Fin de estilos-->
        
    </Window.Resources>
    <DockPanel LastChildFill="True">
        <!--Barra superior con logo y título-->
        <Border DockPanel.Dock="Top" Style="{StaticResource Estilo_de_la_tarjeta_arriba}" Margin="24,16" HorizontalAlignment="Left">
            <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                <Image Source="/imgs/Logo.png" Height="48" Stretch="Uniform"/>
                <TextBlock Text="LiveChat" Margin="12,0,0,0" Style="{StaticResource Estilo_del_titulo_grande}"/>
            </StackPanel>
        </Border>

        <!--Contenido principal-->
        <Grid>
            <!--Tarjeta central-->
            <Border Style="{StaticResource Estilo_de_la_tarjeta}" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="24">
                <Grid>
                    <!--Distribución de columnas-->
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="3*"/>
                        <ColumnDefinition Width="2*"/>
                    </Grid.ColumnDefinitions>

                    <!--Formulario de acceso-->
                    <Border Grid.Column="0" BorderBrush="{StaticResource colorDivisor}" BorderThickness="0,0,1,0" Padding="0,0,16,0">
                        <StackPanel>
                            <TextBlock Text="¡Te damos la bienvenida de nuevo!" Style="{StaticResource Estilo_del_titulo_pequeño}"/>
                            <TextBlock Text="Nos alegra verte de nuevo" Margin="0,0,0,10" Style="{StaticResource Estilo_del_texto_suave}"/>

                            <!--Entrada de email o teléfono-->
                            <StackPanel Margin="0,0,0,10">
                                <TextBlock Text="Correo electrónico o número de telefono" Style="{StaticResource Estilo_del_texto_suave}"/>
                                <TextBox Style="{StaticResource entradaTexto}"/>
                            </StackPanel>

                            <!--Entrada de contraseña y recuperación-->
                            <StackPanel Margin="0,0,0,10">
                                <TextBlock Text="Conraseña" Style="{StaticResource Estilo_del_texto_suave}"/>
                                <PasswordBox Style="{StaticResource Contraseña}"/>
                                <TextBlock Text="¿Olvidaste tu contraseña?" Style="{StaticResource link}" FontSize="12" Margin="0,6,0,0"/>
                            </StackPanel>

                            <!--Opciones y acción principal-->
                            <CheckBox Content="Recordarme" Foreground="{StaticResource colorTexto}" Margin="0,0,0,10"/>
                            <Button Content="Iniciar sesión" Style="{StaticResource boton}"/>

                            <!--Enlace a registro-->
                            <TextBlock Style="{StaticResource link}" FontSize="12" TextAlignment="Center" Margin="0,10,0,0">
                            <Run Text="¿Necesitas una cuenta?"/>
                            <Run Text="Registrarte"/>
                            </TextBlock>
                        </StackPanel>
                    </Border>

                    <!--Sección QR para iniciar sesión desde la app-->
                    <StackPanel Grid.Column="1" Margin="16,0,0,0">
                        <Image Source="/imgs/QR.jpg" Stretch="Uniform" Height="220"/>
                        <TextBlock Text="Código QR" Margin="0,10,0,0" FontWeight="Bold" Foreground="{StaticResource colorTexto}"/>
                        <TextBlock Text="Escanea el código con la app para iniciar sesión" TextWrapping="Wrap" Foreground="{StaticResource colorTextoSuave}"/>
                    </StackPanel>
                </Grid>
            </Border>
        </Grid>
    </DockPanel>
</Window>

```
```

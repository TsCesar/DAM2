**Autor/a:** Cesar

```
```bash
<Window x:Class="TrabajoEntregable.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LiveChat"
        MinWidth="900" MinHeight="600"
        ResizeMode="CanResize"
        WindowStartupLocation="CenterScreen">
    <Window.Background>
        <ImageBrush ImageSource="/imgs/Fondo.png" Stretch="UniformToFill" AlignmentX="Center" AlignmentY="Center"/>
    </Window.Background>

    <Window.Resources>
        <SolidColorBrush x:Key="colorTarjeta" Color="#FFF2E3C6"/>
        <SolidColorBrush x:Key="colorBordeTarjeta" Color="#33AAAAAA"/>
        <SolidColorBrush x:Key="colorDivisor" Color="#26000000"/>
        <SolidColorBrush x:Key="colorNaranja" Color="#E86A33"/>
        <SolidColorBrush x:Key="colorTexto" Color="#000000"/>
        <SolidColorBrush x:Key="colorTextoSuave" Color="#99000000"/>

        <Style x:Key="tituloGrande" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="FontSize" Value="28"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
        </Style>

        <Style x:Key="tituloCard" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="FontSize" Value="20"/>
            <Setter Property="FontWeight" Value="Bold"/>
        </Style>

        <Style x:Key="txtSuave" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTextoSuave}"/>
        </Style>

        <Style x:Key="tarjeta" TargetType="Border">
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

        <Style x:Key="tarjetaTop" TargetType="Border">
            <Setter Property="Background" Value="{StaticResource colorTarjeta}"/>
            <Setter Property="BorderBrush" Value="{StaticResource colorBordeTarjeta}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius" Value="10"/>
            <Setter Property="Padding" Value="10,6"/>
            <Setter Property="Effect">
                <Setter.Value>
                    <DropShadowEffect Color="#6F6F6F" Opacity="0.30" BlurRadius="20" ShadowDepth="0"/>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="entradaTexto" TargetType="TextBox">
            <Setter Property="Height" Value="36"/>
            <Setter Property="Padding" Value="10,6"/>
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="Background" Value="#F7F7F7"/>
            <Setter Property="BorderBrush" Value="#2A2A2A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TextBox">
                        <Border CornerRadius="6" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}">
                            <ScrollViewer x:Name="PART_ContentHost"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="entradaPass" TargetType="PasswordBox">
            <Setter Property="Height" Value="36"/>
            <Setter Property="Padding" Value="10,6"/>
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="Background" Value="#F7F7F7"/>
            <Setter Property="BorderBrush" Value="#2A2A2A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="PasswordBox">
                        <Border CornerRadius="6" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}">
                            <ScrollViewer x:Name="PART_ContentHost"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="btnNaranja" TargetType="Button">
            <Setter Property="Height" Value="44"/>
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="Background" Value="{StaticResource colorNaranja}"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="BorderBrush" Value="{StaticResource colorNaranja}"/>
            <Setter Property="BorderThickness" Value="0"/>
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

        <Style x:Key="linkBasico" TargetType="TextBlock">
            <Setter Property="Foreground" Value="{StaticResource colorTexto}"/>
            <Setter Property="TextDecorations" Value="Underline"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
    </Window.Resources>

    <DockPanel LastChildFill="True">
        <Border DockPanel.Dock="Top" Style="{StaticResource tarjetaTop}" Margin="24,16" HorizontalAlignment="Left">
            <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                <Image Source="/imgs/Logo.png" Height="48" Stretch="Uniform"/>
                <TextBlock Text="LiveChat" Margin="12,0,0,0" Style="{StaticResource tituloGrande}"/>
            </StackPanel>
        </Border>

        <Grid>
            <Border Style="{StaticResource tarjeta}" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="24" MaxWidth="1100">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="3*"/>
                        <ColumnDefinition Width="2*"/>
                    </Grid.ColumnDefinitions>

                    <Border Grid.Column="0" BorderBrush="{StaticResource colorDivisor}" BorderThickness="0,0,1,0" Padding="0,0,16,0">
                        <StackPanel>
                            <TextBlock Text="¡Te damos la bienvenida de nuevo!" Style="{StaticResource tituloCard}"/>
                            <TextBlock Text="Nos alegra verte de nuevo" Margin="0,0,0,10" Style="{StaticResource txtSuave}"/>

                            <StackPanel Margin="0,0,0,10">
                                <TextBlock Text="Correo electrónico o número de teléfono" Style="{StaticResource txtSuave}"/>
                                <TextBox Style="{StaticResource entradaTexto}"/>
                            </StackPanel>

                            <StackPanel Margin="0,0,0,10">
                                <TextBlock Text="Contraseña" Style="{StaticResource txtSuave}"/>
                                <PasswordBox Style="{StaticResource entradaPass}"/>
                                <TextBlock Text="¿Olvidaste tu contraseña?" Style="{StaticResource linkBasico}" FontSize="12" Margin="0,6,0,0"/>
                            </StackPanel>

                            <CheckBox Content="Recordarme" Foreground="{StaticResource colorTexto}" Margin="0,0,0,10"/>
                            <Button Content="Iniciar sesión" Style="{StaticResource btnNaranja}"/>

                            <TextBlock Style="{StaticResource linkBasico}" FontSize="12" TextAlignment="Center" Margin="0,10,0,0">
                                <Run Text="¿Necesitas una cuenta? "/><Run Text="Registrarte"/>
                            </TextBlock>
                        </StackPanel>
                    </Border>

                    <StackPanel Grid.Column="1" Margin="16,0,0,0">
                        <Image Source="/imgs/QR.jpg" Stretch="Uniform" Height="220"/>
                        <TextBlock Text="Código QR" Margin="0,10,0,0" FontWeight="Bold" Foreground="{StaticResource colorTexto}"/>
                        <TextBlock Text="Escanea el código con la app para iniciar sesión." TextWrapping="Wrap" Foreground="{StaticResource colorTextoSuave}"/>
                    </StackPanel>
                </Grid>
            </Border>
        </Grid>
    </DockPanel>
</Window>
```
```

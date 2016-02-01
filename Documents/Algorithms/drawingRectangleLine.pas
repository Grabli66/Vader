
Program
   Uses
       pure2d,
       keyset

Procedure BLine(x0: Integer, y0: Integer, x1: Integer, y1: Integer, color: Integer, canvas: Element, xthickness: Integer, ythickness: Integer)
Var
   steep: Boolean
   iTmp: Integer
   deltax, deltay: Integer
   error: Integer
   ystep: Integer
   x, y: Integer
   xthickOver2, ythickOver2: Integer
Begin

   steep = abs(y1 - y0) > abs(x1 - x0)

   If steep then

       // swap(x0, y0)
       iTmp = x0
       x0 = y0
       y0 = iTmp

       // swap(x1, y1)
       iTmp = x1
       x1 = y1
       y1 = iTmp

   Endif

    If x0 > x1 then

        // swap(x0, x1)
       iTmp = x0
       x0 = x1
       x1 = iTmp

        // swap(y0, y1)
       iTmp = y0
       y0 = y1
       y1 = iTmp

    Endif

    deltax = x1 - x0
    deltay = abs(y1 - y0)
    error = deltax / 2
    ystep = 0
    y = y0

    If y0 < y1 then ystep = 1 else ystep = -1

    For x = x0 to x1

       xthickOver2 = xthickness/2
       ythickOver2 = ythickness/2

       If steep then
           Rect(y-ythickOver2, x-xthickOver2, xthickness, ythickness, color, TRUE, canvas)
       Else
           Rect(x-xthickOver2, y-ythickOver2, xthickness, ythickness, color, TRUE, canvas)
       Endif

       error = error - deltay
       If error < 0 then
           y = y + ystep
           error = error + deltax
       Endif
   Next

End

Begin

   OpenScreen(640, 480, 32, FALSE)

   While (KeyHits(VK_ESCAPE) = 0)
       Cls

       BLine(320, 240, MouseX, MouseY, ToRGBA(0,0,255), ScreenBuffer, 5, 5)

       Flip
       Pause(1)
   Wend

End
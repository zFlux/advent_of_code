program challenge_1
    implicit none
    integer :: step, inputMatrix(10,11), howManyBurst
    inputMatrix = readInput("input.txt")
    howManyBurst = 0

    do step=1,100
        inputMatrix = increaseEnergy(inputMatrix)
        inputMatrix = burstOctopi(inputMatrix)
        howManyBurst = howManyBurst + inputMatrix(1,11)
    end do

    write(*,*) "How Many Burst: ", howManyBurst
    
contains

function readInput(fileName) result(inputMatrix)
    character(len=9), intent(in) :: fileName
    integer :: inputMatrix(10,11)

    integer :: ioStatus, row, column
    character(len=10) :: fileline ! Declare a variable of 10 characters for a line of file data
    
    open(10, file=fileName, form="FORMATTED", status="OLD", action="READ")
    do row=1,10
        read(10,*,iostat=ioStatus) fileline
        if (ioStatus/=0) exit
        do column=1,10
            read(fileLine(column:column),'(i1)') inputMatrix(column,row)
        end do
    end do
    close(10)
end function

function increaseEnergy(input) result(output)
    integer, intent (in) :: input(10,11) ! input
    integer              :: output(10,11) ! output
    integer :: i, j
    do i=1,10
        do j=1,10
            output(i,j) = input(i,j) + 1
        end do
    end do
end function

function burstOctopi(input) result(output)
    integer, intent (in) :: input(10,11) ! input
    integer              :: output(10,11) ! output
    integer :: i, j, upleft(2), up(2), upright(2), right(2), downright(2), down(2), downleft(2), left(2)
    integer :: alreadyBurstOctopi(10,10), howManyBurst

    alreadyBurstOctopi = 0
    howManyBurst = 0

    output = input

    i = 1
    j = 1
    do while (j .lt. 11)
        upleft(1) = i-1
        upleft(2) = j-1
        up(1) = i 
        up(2) = j-1
        upright(1) = i+1
        upright(2) = j-1
        right(1) = i+1
        right(2) = j
        downright(1) = i+1
        downright(2) = j+1
        down(1) = i 
        down(2) = j+1
        downleft(1) = i-1
        downleft(2) = j+1
        left(1) = i-1
        left(2) = j
     
        if (output(i,j) .gt. 9 .and. .not. alreadyBurstOctopi(i,j) .eq. 1) then
            howManyBurst = howManyBurst + 1

            output(i,j) = 0
            alreadyBurstOctopi(i,j) = 1

            if(canIncrease(upleft, alreadyBurstOctopi)) then
                output(upleft(1), upleft(2)) = output(upleft(1), upleft(2)) + 1
            end if
            if(canIncrease(up, alreadyBurstOctopi)) then
                output(up(1), up(2)) = output(up(1), up(2)) + 1
            end if
            if(canIncrease(upright, alreadyBurstOctopi)) then
                output(upright(1), upright(2)) = output(upright(1), upright(2)) + 1
            end if
            if(canIncrease(right, alreadyBurstOctopi)) then
                output(right(1), right(2)) = output(right(1), right(2)) + 1
            end if
            if(canIncrease(downright, alreadyBurstOctopi)) then
                output(downright(1), downright(2)) = output(downright(1), downright(2)) + 1
            end if
            if(canIncrease(down, alreadyBurstOctopi)) then
                output(down(1), down(2)) = output(down(1), down(2)) + 1
            end if
            if(canIncrease(downleft, alreadyBurstOctopi)) then
                output(downleft(1), downleft(2)) = output(downleft(1), downleft(2)) + 1
            end if
            if(canIncrease(left, alreadyBurstOctopi)) then
                output(left(1), left(2)) = output(left(1), left(2)) + 1
            end if

            ! reset the loop vars
            i = 1
            j = 1
            cycle
        end if

        if (i .eq. 10) then
            i = 1
            j = j + 1
        else 
            i = i + 1
        end if  
  
    
    end do

    output(1,11) = howManyBurst
end function

logical function canIncrease(point, alreadyBurstOctopi) result(tf)
integer, intent(in) :: point(2)
integer             :: alreadyBurstOctopi(10,10)
tf = point(1) .gt. 0 .and. point(1) .lt. 11 .and. point(2) .gt. 0 .and. &
        point(2) .lt. 11 .and. .not. alreadyBurstOctopi(point(1), point(2)) .eq. 1
end function canIncrease

subroutine printMatrix(input)
    integer, intent (in) :: input(10,10) ! input
    integer :: i
    do i=1,10
    write(*,'(10(I2))') input(1, i), input(2, i), input(3, i), input(4, i), input(5, i)&
    , input(6, i),input(7, i), input(8, i), input(9, i), input(10, i)
    end do
    write(*,*) ""
end subroutine

end program challenge_1
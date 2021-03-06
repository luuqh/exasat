subroutine laplacian4(lo,hi,ng,fac,fac2,A0,Anext)

  integer,          intent(in ) :: lo(3),hi(3),ng
  double precision, intent(in ) :: fac,fac2
  integer                       :: i,j,k

  double precision, intent(out  ) :: Anext(lo(1)-ng:hi(1)+ng,lo(2)-ng:hi(2)+ng,lo(3)-ng:hi(3)+ng)
  double precision, intent(in   ) ::    A0(lo(1)-ng:hi(1)+ng,lo(2)-ng:hi(2)+ng,lo(3)-ng:hi(3)+ng)

  !$OMP PARALLEL DO PRIVATE(i,j,k,eint,rhoinv)
  do k = lo(3),hi(3)
     do j = lo(2),hi(2)
        do i = lo(1),hi(1)
           Anext(i,j,k) =  &
             (A0(i+1,j,k) + A0(i-1,j,k) &
             +A0(i,j+1,k) + A0(i,j-1,k) &
             +A0(i,j,k+1) + A0(i,j,k-1) &
             +A0(i+2,j,k) + A0(i-2,j,k) &
             +A0(i,j+2,k) + A0(i,j-2,k) &
             +A0(i,j,k+2) + A0(i,j,k-2) &
             +A0(i+3,j,k) + A0(i-3,j,k) &
             +A0(i,j+3,k) + A0(i,j-3,k) &
             +A0(i,j,k+3) + A0(i,j,k-3) &
             +A0(i+4,j,k) + A0(i-4,j,k) &
             +A0(i,j+4,k) + A0(i,j-4,k) &
             +A0(i,j,k+4) + A0(i,j,k-4) &
             - 6.0e0 * A0(i,j,k))/(fac*fac)
        enddo
     enddo
  enddo
  !$OMP END PARALLEL DO

end subroutine laplacian4

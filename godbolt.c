unsigned char mod(long x, unsigned char m);
long dot_prod(void *A, void *B, int n, int i, int j);
void matrix_prod(char *A, char *B, char *C, int n);
void print_matrix(void *A, int n);


#define N 4


char A[N][N] = { 5, 11, 10,  3,
                10,  6,  2,  1,
                 6,  3, 14, 13,
                 8,  5,  2,  0};

char B[N][N] = {10, 12, 14,  5,
                12, 10,  1,  1,
                12,  0, 12, 10,
                12,  0,  1, 10};

char C[N][N];


int main () {
    matrix_prod(A, B, C, N);

    print_matrix(A, N);
    print_matrix(B, N);
    print_matrix(C, N);
    return 0;
}

void matrix_prod(char *A, char *B, char *C, int n){
    for(int i=0; i<n; i++){
        for(int j=0; j<n; j++)
        {
            C[i*n+j] = mod(dot_prod(A, B, n, i, j), 17);
        }
    }
}

void print_matrix(void *A, int n) {

}

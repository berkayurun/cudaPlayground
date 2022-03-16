#include <iostream>
#include <math.h>

__global__
void add(float *x, float *y){
	int index = threadIdx.x;

	x[index] += y[index];
}

void printVectors(int n, float *x, float *y){
	std::cout << "Printing x - y: " << std::endl;
	for(int i = 0; i < n; i++){
		std::cout << x[i] << " - " << y[i] << std::endl;
	}
}

int main(){
	int n = 10;
	float *x;
	float *y;

	cudaMallocManaged(&x, n * sizeof(float));
	cudaMallocManaged(&y, n * sizeof(float));

	for(int i = 0; i < n; i++){
		x[i] = 1.0f;
		y[i] = 3.5f;
	}

	printVectors(n, x, y);

	add<<<1, n>>>(x, y);

	cudaDeviceSynchronize();

	printVectors(n, x, y);
}


#include <iostream>

using namespace std;

class Data{
public:
    int min;
    int max;
    bool BST;
};

Data* preOrder(int* a, int i, int N){
    printf("%d ", a[i]); //cout << a[i]<< " " ;

    Data* leftData;
    Data* rightData;
    Data* newData = new Data();

    if(2*i+2 < N){
        leftData = preOrder(a, 2*i+1, N);
        rightData = preOrder(a, 2*i+2, N);
        if(leftData->BST == true && rightData->BST == true && leftData->max <= a[i] && rightData->min >= a[i]){
            newData->min = leftData->min;
            newData->max = rightData->max;
            newData->BST = true;
        } else {
            newData->BST = false;
        }

    } else if(2*i+1 < N){
        leftData = preOrder(a, 2*i+1, N);
        if(leftData->BST == true && leftData->max <= a[i]){
            newData->min = leftData->min;
            newData->max = a[i];
            newData->BST = true;
        } else if(leftData->BST == true && leftData->min >= a[i]) {
            newData->min = a[i];
            newData->max = leftData->max;
            newData->BST = true;
        } else {
            newData->BST = false;
        }
    } else {
        newData->min = a[i];
        newData->max = a[i];
        newData->BST = true;
    }

    return newData;
}

int main()
{
    int N;
    char temp;

    scanf("%d", &N);//cin >> N;

    int *a;
    a = new int[N];
    for(int i = 0; i < N; i++){
        scanf("%d", &a[i]);//cin >> a[i];
        if(i != N-1)
            scanf("%c", &temp);//cin >> temp;
    }

    Data* result;

    result = preOrder(a, 0, N);
    //printf("\n");//cout << endl;
    if(result->BST == true)
        printf("\ntrue\n");//cout << "true" << endl;
    else
        printf("\nfalse\n");//cout << "false" << endl;

    return 0;
}

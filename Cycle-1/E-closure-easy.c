#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void main()
{
    int n,end,i,j,k;
    char state1[3],input[3],state2[3];
    char state[20][20],result[20][20],currstate[3];
    FILE *fp=fopen("NFA.txt","r");

    printf("Enter the no of states:");
    scanf("%d",&n);

    printf("Enter the states:");
    for(i=0;i<n;i++)
    {
        scanf("%s",state[i]);
    }

    for(k=0;k<n;k++)
    {
        i=0;
        strcpy(currstate,state[k]);
        strcpy(result[i],currstate);
        i++;

        while((end=fscanf(fp,"%s %s %s",state1,input,state2))!=EOF)
        {
            if(strcmp(state1,currstate)==0)
            {
                if(strcmp(input,"e")==0)
                {
                    strcpy(result[i],state2);
                    strcpy(currstate,state2);
                    i++;
                }
            }
        }
        printf("E Closure of %s:{",state[k]);
        for(int j=0;j<i;j++)
        {
            printf("%s ",result[j]);
        }
        printf("}\n");
        rewind(fp);
    }
    fclose(fp);
}

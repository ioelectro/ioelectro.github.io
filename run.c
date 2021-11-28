#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE_OF_BUFFER 0xfffff
#define SIZE_OF_NAME 64
#define MAX_VAR_NUM  128

typedef struct
{
    size_t size;
    char * loc;
    char name[SIZE_OF_NAME];
}my_var;

my_var var_list[MAX_VAR_NUM];
unsigned int var_c=0;

void print_var_list()
{
    int i,j;
    for(i=0;i<var_c;i++)
    {
        printf("%d: %s[%d]\r\n",i,var_list[i].name,var_list[i].size);
        for(j=0;j<var_list[i].size;j++)
        {
            putchar(var_list[i].loc[j]);
        }
        puts("\r\n");
    }
}

int search_var_list(char* Name)
{
    int i,j;
    for(i=0;i<var_c;i++)
    {
        if(strcmp(Name,var_list[i].name)==0)return i;
    }
    return -1;
}

void catch_var_list(char * fileName)
{
    FILE *fp;
    char buff[SIZE_OF_BUFFER];
    size_t s,i,k;

    fp=fopen(fileName,"r");
    s=fread(buff,1,SIZE_OF_BUFFER,fp);
    for(i=0;i<s;i++)
    {
        if(buff[i]=='{'&& buff[i+1]=='{')
        {
            i+=2;
            for(k=0;buff[i]!='\n'&&buff[i]!='\r'&&buff[i]!=' '&&buff[i]!='}';k++,i++)
            {
                var_list[var_c].name[k]=buff[i];
            }
            if(buff[i]!='}')i++;
            if(buff[i]=='\r'||buff[i]=='\n')i++;
            var_list[var_c].name[k]='\0';
            var_list[var_c].size=i;
            var_list[var_c].loc=&buff[i];

        }
        if(buff[i]=='}'&&(buff[i+1]=='}'))
        {
            var_list[var_c].size=i-var_list[var_c].size;
            var_list[var_c].loc=malloc(var_list[var_c].size);
            memcpy(var_list[var_c].loc,&buff[i-var_list[var_c].size],var_list[var_c].size);
            var_c++;
        }
    }
    fclose(fp);
}

void replace_var_list(char * fileName)
{
    FILE *fp,*fpt;
    char buff[SIZE_OF_BUFFER];
    size_t s,i,k;

    char var_name[SIZE_OF_NAME];
    int ss=-1;

    fp=fopen(fileName,"r");
    fpt=fopen("Temp.html","w");

    s=fread(buff,1,SIZE_OF_BUFFER,fp);
    for(i=0;i<s;i++)
    {
        if(buff[i]=='{'&& buff[i+1]=='{')
        {
            i+=2;
            for(k=0;buff[i]!='}';k++,i++)
            {
                var_name[k]=buff[i];
            }
            var_name[k]='\0';
            i++;

            ss=search_var_list(var_name);
            if(ss!=-1)
            {
                fwrite(var_list[ss].loc,var_list[ss].size,1,fpt);
            }
        }
        else
        {
            fwrite(&buff[i],1,1,fpt);
        }
    }
    fclose(fp);
    fclose(fpt);
}

void clear_var_list()
{
    int i;
    for(i=0;i<var_c;i++)
    {
        free(var_list[i].loc);
    }
}

int main(int argc,char* argv[])
{
    int j;

    for(j=argc-1;j>0;j--)
    {
        if(j==1)
        {
            print_var_list();
            replace_var_list(argv[j]);
        }
        else catch_var_list(argv[j]);
    }
    clear_var_list();
    return 0;
}
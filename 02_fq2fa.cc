#include   <iostream>  
#include   <fstream>  
#include   <cstring>  
#include   <cstdlib>  
using namespace std;  
  
long line = 0;   
int main(int argc,char *argv[])   
{   
    ifstream fin;   
    ofstream fout;   
    if(argc != 3) {   
         cout << "ERROR: illegal argument number: " << argc << endl;   
         cout << "Uasage: \n \t fq2fa fastaq_file fasta_file \n" <<endl;   
         exit(0);   
     }   
     
     fin.open(argv[1]);   
     fout.open(argv[2]);   
     if(!fin.good()) {   
           cout << "ERROR: illegal input file path: " << argv[1] <<endl;   
           cout << "Uasage: \n \t fq2fa fastaq_file fasta_file \n" <<endl;   
           exit(0);   
       }   
       else if(!fout.good()) {   
                cout << "ERROR: illegal output file path" << endl;   
                cout << "Uasage: \n \t fq2fa fastaq_file fasta_file \n" <<endl;   
                exit(0);   
          }   
          cout << "Converting Data..." << endl;   
          int mod;   
          line=0;   
          while(fin != NULL) {   
                    string s;   
                    getline(fin,s,'\n');   
                    if (s==""){   
                            continue;   
                    }   
                    line=line+1;   
                    mod=line % 4;   
                    if (mod == 1){   
                            s[0]='>';   
                            fout << s << endl;   
                    }   
                    if (mod == 2){   
                              fout << s << endl;   
                    }   
            }   
            cout << "finished!" << endl;   
            fout.close();   
            fin.close();   
            return 0;   
}  


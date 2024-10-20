#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define ll long long

typedef struct set{
    ll value1;
    ll value2;
    ll index;
    ll Flag; //flag for actually the same

}Set;

int compareInt(const void *pa, const void *pb){
    Set *a = (Set*)pa;
    Set *b = (Set*)pb;
    if(a->value1 > b->value1){
        return 1;
    }
    else if(a->value1 == b->value1){
        if(a->value2 > b->value2)
            return 1;
        else if(a->value2 == b->value2){
            if(a->Flag > b->Flag)
                return 1;
            else if(a->Flag == b->Flag)
                return 0;
            else
                return -1;
        }
        else
            return -1;
    }
    else
        return -1;
}

int main(void){
    ll k, l, flag; //k lines, l = len
    scanf("%lld%lld%lld", &k, &l, &flag);
    char magic[k][l+1];
    for(ll i = 0; i < k; i++){
        scanf("%s", magic[i]);
    }
    Set set[k];
    ll mod1 = 2646216567629137;
    ll mod2 = 12646216567629137;
    for(ll i = 0; i < k; i++){
        set[i].value1 = 0;
        set[i].value2 = 0;
        set[i].index = i;
        set[i].Flag = 0;
        for(ll j = l-1; j >= 0; j--){
            set[i].value1 = (set[i].value1*97+magic[i][j]-'!') % mod1;
            set[i].value2 = (set[i].value2*97+magic[i][j]-'!') % mod2;
        }
    }
    qsort(set, k, sizeof(Set), compareInt);
    Set tmp = set[0];
    ll similar = 0;
    ll answer = 0;
    ll count = 1;
    ll Flag_cnt = 1;
    for(ll i = 1; i < k; i++){
        if(set[i].value1 == tmp.value1 && set[i].value2 == tmp.value2){
            if(similar == 0){
                printf("Yes\n");
                similar = 1;
            }
            count++;
            set[i-1].Flag = Flag_cnt;
            set[i].Flag = Flag_cnt;
            if(flag == 0){
                printf("%lld %lld\n", tmp.index, set[i].index);
                return 0;
            }
        }
        else{
            tmp = set[i];
            answer += count*(count-1)/2;
            count = 1;
            Flag_cnt++;
        }
    }
    answer += count*(count-1)/2;
    count = 1;
    Set TMP[k];
    ll K = -1;
    ll tmp_flag = -1;
    for(ll i = 0; i < k; i++){
        if(set[i].Flag != tmp_flag || set[i].Flag == 0){
            K++;
            TMP[K].value1 = set[i].value1;
            TMP[K].value2 = set[i].value2;
            TMP[K].index = set[i].index;
            TMP[K].Flag = 1;
        }
        else{
            TMP[K].Flag++;
        }
        tmp_flag = set[i].Flag;
    }
    K++;
    ll power1 = 1, power2 = 1;
    for(ll i = 0; i < l; i++){
        Set tmp_arr[K];
        for(ll j = 0; j < K; j++){
            tmp_arr[j].index = TMP[j].index;
            tmp_arr[j].value1 = ((TMP[j].value1 - (magic[TMP[j].index][i] - '!')*power1) % mod1 + mod1) % mod1;
            tmp_arr[j].value2 = ((TMP[j].value2 - (magic[TMP[j].index][i] - '!')*power2) % mod2 + mod2) % mod2;
            tmp_arr[j].Flag = TMP[j].Flag; 
        }
        qsort(tmp_arr, K, sizeof(Set), compareInt);
        Set tmp = tmp_arr[0];
        ll minus_sum = tmp.Flag*(tmp.Flag-1)/2;
        ll c_sum = tmp.Flag;
        ll b_flag = 0;
        for(ll j = 1; j < K; j++){
            if(tmp_arr[j].value1 == tmp.value1 && tmp_arr[j].value2 == tmp.value2){
                b_flag = 1;
                if(similar == 0){
                    printf("Yes\n");
                    similar = 1;
                }
                c_sum += tmp_arr[j].Flag;
                minus_sum += tmp_arr[j].Flag*(tmp_arr[j].Flag-1)/2;
                if(flag == 0){
                    printf("%lld %lld\n", tmp.index, tmp_arr[j].index);
                    return 0;
                }
            }
            else{
                if(b_flag == 1)
                    answer += c_sum*(c_sum-1)/2 - minus_sum;
                b_flag = 0;
                tmp = tmp_arr[j];
                c_sum = tmp.Flag;
                minus_sum = tmp.Flag*(tmp.Flag-1)/2;
            }
        }
        if(b_flag == 1)
            answer += c_sum*(c_sum-1)/2 - minus_sum;
        power1 = (power1 * 97) % mod1;
        power2 = (power2 * 97) % mod2;
    }
    if(similar == 1){
        printf("%lld\n", answer);
    }
    else
        printf("No\n");
    return 0;
}
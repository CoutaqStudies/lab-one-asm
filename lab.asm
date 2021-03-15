nata segment 'code'
assume cs:nata
org 100h
begin: jmp main
;--------------------------------- DATA
Route DB 10,'Донецк-Снежное        ',11,'Азов-Белогорск        ' ; 12 ???????? ?? ?????
DB 12,'Волгоград-Галич       ',33,'Железногорск-Задонск  '
DB 98,'Иркутск-Калуга        ',87,'Любим-Нефтегорск      '
DB 25,'Новосибирск-Омск      ',19,'Пермь-Рязань          '
DB 31,'Саратов-Тверь         ',67,'Углегорск-Якутск      '
Rezult DB 22 Dup(?),'$'
Buf DB 3,3 Dup(?)
NumTrain DB ?
Mes DB 'Маршрута с этим номером поезда нет !$'
Eter DB 10,13,'$'
Podskaz DB 'Введите номер поезда:$'
;---------------------------------
main proc near
;------------------------------------- PROGRAM
; ------ Подсказка -------
mov ah,09
lea dx,podskaz
int 21h
; Ввод строки
mov ah,0ah
lea dx,Buf
int 21h
; Преобразование символов в число
; Получаем десятки из буфера
mov bl,buf+2
sub bl,30h
mov al,10
imul bl ; в al - десятки
; Получаем единицы из буфера
mov bl,buf+3
sub bl,30h
; Складываем ------
add al,bl
mov numtrain,al ; сохраняем в numtrain
; -------- Переход на новую строку ---
mov ah,09h
lea dx,eter
int 21h
; --- сканирование таблицы маршрутов ----
cld ; искать слева направо

mov cx,230 ; сколько байт сканировать
lea di,route ; строка, где искать
mov al,numtrain ; что искать
repne scasb ; поиск
je @m2
; ------- Сообщение об отсутствии маршрута
mov ah,09h
lea dx,Mes
int 21h
jmp @m3 ; выходим из программы
; -------- переписываем в результат
@m2:
cld
mov si,di
lea di,rezult
mov cl,22
rep movsb
; ----- Вывод результата ----
mov ah,09h
lea dx,rezult
int 21h
;-------------------------------------
@m3: mov ah,08
int 21h
ret
main endp
nata ends
end begin
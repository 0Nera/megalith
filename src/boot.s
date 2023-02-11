// Основное ядро - void kernel_main(uint32_t eax, uint32_t ebx, uint32_t esp)
.extern kernel_main
.global _start
     
.set MB_MAGIC, 0x1BADB002     // Это 'магическая' константа, которая укажет что этот файл - ядро ОС.
.set MB_FLAGS, (1 << 0) | (1 << 1) // 1: Загружать модули по границам страницы и 2: предоставлять карту памяти (это пригодится для менеджера памяти).
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS)) // Наконец, мы вычисляем контрольную сумму, которая включает в себя все предыдущие значения
     
// Теперь мы запускаем раздел исполняемого файла, который будет содержать наш заголовок Multiboot
.section .multiboot
    .align 4 // Следующие данные будут выровнены по размеру, кратному 4 байтам
    // Используйте ранее вычисленные константы в исполняемом коде
    .long MB_MAGIC
    .long MB_FLAGS
    .long MB_CHECKSUM
     
// Этот раздел содержит данные, инициализированные нулями при загрузке ядра
.section .bss
    // Нашему C-коду для запуска понадобится стек. Здесь мы выделяем 4096 байт (или 4 килобайта) для нашего стека.
    .align 16
    stack_bottom:
        .skip 4096
    stack_top:
     
// Этот раздел содержит наш фактический ассемблерный код, который будет выполняться при загрузке нашего ядра
.section .text
_start:
    // Настройка среды
    cli      // Отключаем прерывания
    finit	 // Включаем FPU
    
    mov $stack_top, %esp // Установка стека
    
    // Отправляем аргументы для функции ядра
    push    %esp    // Стек
    push    %ebx    // Структура multiboot
    push    %eax    // Магическое число
    
    // Вызов ядра
    call kernel_main
     
    // В случае если код дойдет до сюда(а так не должно быть!)
_halt_me:
    cli      	 // Отключаем прерывания
    hlt      	 // Остановите процессор
    jmp _halt_me // Повторить
    
// Перенос строки в конце кода - обязателен!

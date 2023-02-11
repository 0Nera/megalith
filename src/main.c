/**
 * @brief Число от 0 до 255 (1 байт)
 * 
 */
typedef unsigned char uint8_t;


/**
 * @brief Число от 0 до 65536 (2 байта)
 * 
 */
typedef unsigned short uint16_t;


/**
 * @brief Число от 0 до 4294967296 (4 байта)
 * 
 */
typedef unsigned int uint32_t;


/**
 * @brief Видеобуффер
 * 
 */
uint8_t *video_buff = (uint8_t*)0xB8000;


/**
 * @brief Атрибут для функций которые не передают после выполнения управление
 * 
 */
#define noreturn __attribute__((__noreturn__))


/**
 * @brief Основная функция ядра, вызывается из boot.s
 * 
 * @param eax Магическое число
 * @param ebx Структура multiboot
 * @param esp Магическое число
 */
noreturn 
void kernel_main(uint32_t eax, uint32_t ebx, uint32_t esp) {
    video_buff[0] = '1';    // Выводим символ 1
    video_buff[1] = 0x0F;   // Фон(0x0) - черный, текст(0xF) - белый

    // Не даём процессору перегреться
    for (;;) {
        asm volatile("hlt");
    }

    // До этого места не должно дойти
}

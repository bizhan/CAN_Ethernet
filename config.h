#ifndef __C2E_CONFIG_H
#define __C2E_CONFIG_H
#include <stdint.h>

typedef struct
{
	uint32_t state;
	uint32_t event;
	uint32_t (*fn)(void);
} transition_t;																						// state machine transition struct

#ifndef DHCP_EXPIRE_TIMER_SECS
#define DHCP_EXPIRE_TIMER_SECS 45			// Timeout for DHCP address request
#endif
#define UDP_PORT_RX 11898
#define UDP_PORT_TX 11899
#define CAN_FRAME_SIZE 14                   // size of CAN frame to be sent via UDP
#define CAN_UPDATERATE 1 					// rate at which to display received CAN message updates
#define RING_BUF_SIZE (CAN_FRAME_SIZE*160)  // size of ring buffer, accomodate up to 160 frames, probably a bit excessive
#define CAN_FIFO_SIZE   (8 * 8)             // size of FIFO buffers allocated to the CAN controller - 8 messages can each hold a max of 8 bytes
#define CAN_BITRATE 1000000                 // set CAN bitrate to 1Mbps
#define EXT_FLAG_POS 12                     // position of CAN message ID flag in CAN frame
#define RTR_FLAG_POS 13                     // position of CAN remote transmission flag in CAN frame
#define TRIGGER_THRESHOLD 1                 // number of received CAN frames required to trigger a UDP send
// state machine state declarations
#define ST_ANY -1 							// catch all state
#define ST_INIT 0
#define ST_BOARDINIT 1
#define ST_ETHINIT 2						// Ethernet initialized
#define ST_CANINIT 3						// CAN initialized
#define ST_INTENABLED 4 					// Interrupts enabled
#define ST_LWIPINIT 5						// lwIP initialized
#define ST_NETIFINIT 6						// netif initialized
#define ST_HASIP 7							// have IP address
#define ST_GWDISCOVER 8
#define ST_GWREPLY 9
#define ST_GWACK 10
#define ST_CANDATA 11
#define ST_TERM 99
//state machine event declarations
#define EV_ANY -1 							// catch all event
#define EV_POWERON 0
#define EV_IPCHANGED 1 							// IP address obtained 
#define EV_IPDISPLAYED 2						// IP has been displayed

#endif
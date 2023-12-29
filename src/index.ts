console.clear();

import { Elysia } from "elysia";
import { cors } from '@elysiajs/cors'
import { PrismaClient } from '@prisma/client';
import { generate } from 'promptparse'
import promptpay from 'th-promptpay-qr'
const prisma = new PrismaClient();

const app = new Elysia()

app.use(cors());

app.get('/bill/:id', async (req) => {
  try {
    const id: any = Number(req.params.id);

    const get_bill = await prisma.bill.findFirst({
      where: {
        id: id
      }
    })

    if (get_bill) {
      const get_history = await prisma.topup_history.findMany({
        where: {
          bill_id: req.params.id
        }
      })

      return {
        status: 200,
        data: {
          id: get_bill.id,
          name: get_bill.name,
          amount: get_bill.amount,
          reciver_code: get_bill.reciver_code,
          reciver_type: get_bill.reciver_type,
          bill_history: get_history
        }
      }
    } else {
      return {
        status: 404
      }
    }
  } catch (error) {
    return {
      status: 500,
      error: error
    }
  }
})

app.post("/bill/new", async (req) => {
  try {
    const body: any = req.body;
    const create_bill = await prisma.bill.create({
      data: {
        name: body.name,
        amount: Number(body.amount),
        reciver_code: body.reciver_code,
        reciver_type: body.reciver_type,
        amount_bill: 0.00
      }
    })

    return {
      status: 200,
      data: {
        bill_id: create_bill.id
      }
    }
  } catch (error) {
    console.log(error);
    
    return {
      status: 500,
      error: error
    }
  }
})

app.post("/bill/topup/:id", async (req) => {
  try {
    const body: any = req.body;
    const id: any = Number(req.params.id)
    const check_bill = await prisma.bill.findFirst({
      where: {
        id: id
      }
    })


    if (check_bill) {
      if (check_bill.amount == check_bill.amount_bill) {
        return {
          status: 400,
          code: "bill is pay success"
        }
      } else {
        if (body.amount > check_bill.amount) {
          return {
            status: 400,
            code: "amoutn is more amoutn bill"
          }
        } else {
          const type = check_bill.reciver_type;

          if (type == "truemoney") {
            const payload = generate.truemoney({
              mobileNo: check_bill.reciver_code,
              amount: body.amount,
              message: check_bill.name
            })

            return {
              status: 200,
              data: { payload }
            }
          } else {
            const payload = promptpay.getPromptpayCode(check_bill.reciver_code, body.amount);

            return {
              status: 200,
              data: { payload }
            }
          }
        }
      }
    } else {
      return {
        status: 404
      }
    }
  } catch (error) {
    console.log(error);

    return {
      status: 500,
      error: error
    }
  }
})

app.listen(3000);

console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`
);

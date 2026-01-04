from multiprocessing import Process, Queue
import time

def sad_function(q):
    time.sleep(0.5)
    # This line is commented out to simulate NOT sending anything:
    # q.put("something happened")
    raise SystemExit("boom")  # simulate crash

def run():
    q = Queue()
    p = Process(target=sad_function, args=(q,))
    p.start()

    try:
        # Simulate Elixir's `receive` with timeout
        msg = q.get(timeout=1)
        print("MESSAGE RECEIVED:", msg)
    except:
        print("Nothing happened as far as I am concerned")

    p.join()

if __name__ == "__main__":
    run()

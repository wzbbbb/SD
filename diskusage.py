import os
d=dict()

def disk_usage(path):
    st = os.statvfs(path)
    d['free'] = st.f_bavail * st.f_frsize
    d['total'] = st.f_blocks * st.f_frsize
    d['used'] = (st.f_blocks - st.f_bfree) * st.f_frsize
    return d['total'] , d['used'], d['free']
print( disk_usage('/'))
print(disk_usage('/usr'))
print(disk_usage('/tmp'))

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ONLINE_SHOP
{
    public partial class Form1: Form
    {
        public string connectString;
        public string PH;
        SqlConnection conn;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
            if (PH == "KH") label4.Text = "Khách hàng";
            else label4.Text = "Nhân viên";
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (PH == "KH")
                {
                    string email = txtTenDN.Text;
                    string mk = txtMK.Text;
                    string sqlexeclogin = "EXEC SP_LOGIN_KH '" + email + "', N'" + mk + "'";
                    SqlCommand cmd = new SqlCommand(sqlexeclogin, conn);
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Đăng nhập thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    Form2 f2 = new Form2();
                    f2.connectString = connectString;
                    f2.tendn = email;
                    f2.mk = mk;
                    this.Hide();
                    f2.Show();
                }
                else
                {
                    string email = txtTenDN.Text;
                    string mk = txtMK.Text;
                    string sqlexeclogin = "EXEC SP_LOGIN_NV '" + email + "', N'" + mk + "'";
                    SqlCommand cmd = new SqlCommand(sqlexeclogin, conn);
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Đăng nhập thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    Form5 f5 = new Form5();
                    f5.connectString = connectString;
                    f5.tendn = email;
                
                    this.Hide();
                    f5.Show();

                }
                
            }
            catch (SqlException error)
            {
                string errorStr = error.ToString();
                string[] arrStr0 = errorStr.Split(':');
                string[] arrStr = arrStr0[1].Split('\n');
                MessageBox.Show(arrStr[0].ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            txtMK.Text = null;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form0 f0 = new Form0();
            this.Close();
            f0.Show();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            if (PH == "KH")
            {
                Form4 f4 = new Form4();
                f4.connectString = connectString;
                f4.Show();
            }
            else MessageBox.Show("Nhân viên không thể tự đăng ký tài khoản", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}

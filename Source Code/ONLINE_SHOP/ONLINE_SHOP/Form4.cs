using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace ONLINE_SHOP
{

    
    public partial class Form4 : Form
    {
        public string connectString;

        SqlConnection conn;
        public Form4()
        {
            InitializeComponent();
        }

        private void Form4_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            conn.Close();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string makh = textBox1.Text;
            string hoten = textBox2.Text;
            string nsinh = dateTimePicker1.Value.ToString();
            string email = textBox3.Text;
            string pass = textBox4.Text;

            try
            {
                string sqlexec1 = "EXEC SP_INS_KHACHHANG '" + makh + "', N'" + hoten + "', '" + nsinh + "', '" + email + "', N'" + pass + "'";
                SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
                cmd1.ExecuteNonQuery();
                MessageBox.Show("Đăng ký thành công.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                conn.Close();
                this.Close();
            }
            catch (SqlException error)
            {
                string errorStr = error.ToString();
                string[] arrStr0 = errorStr.Split(':');
                string[] arrStr = arrStr0[1].Split('\n');
                MessageBox.Show(arrStr[0].ToString() + "\nĐăng ký thất bại.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {
            
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}

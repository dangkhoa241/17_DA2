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
    public partial class Form8 : Form
    {
        public string connectString;
        public string manv;
        public string hoten;
        public string tendn;
        SqlConnection conn;
        public Form8()
        {
            InitializeComponent();
        }

        private void Form8_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form5 f5 = new Form5();
            f5.connectString = connectString;
            f5.tendn = tendn;
            this.Close();
            f5.Show();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            string nam = textBox1.Text;
            string sqlexec1 = "EXEC SP_TKDT '" + nam + "'";
            SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
            cmd1.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }
    }
}

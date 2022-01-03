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
    public partial class Form7 : Form
    {
        public string connectString;
        public string tendn;
        public string mk;
        public string manv;
        public string hoten;
        public string madh;
        SqlConnection conn;
        public Form7()
        {
            InitializeComponent();
        }

        private void Form7_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();

            label2.Text = tendn;

            string sqlexec1 = "EXEC SP_SEL_DH '" + tendn + "'";
            SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
            cmd1.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;



            madh = dataGridView1.Rows[0].Cells[0].Value.ToString();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        
        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                madh = row.Cells[0].Value.ToString();
            }
        }
        private void button4_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form2 f2 = new Form2();
            f2.connectString = connectString;
            f2.tendn = tendn;
            f2.mk = mk;
            this.Close();
            f2.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form8 f8 = new Form8();
            f8.connectString = connectString;
            f8.manv = manv;
            f8.hoten = hoten;
            f8.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form9 f9 = new Form9();
            f9.tendn = tendn;
            f9.madh = madh;
            f9.connectString = connectString;
            f9.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form10 f10 = new Form10();
            f10.connectString = connectString;
            f10.manv = manv;
            f10.hoten = hoten;
            f10.mk = mk;
            f10.Show();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}

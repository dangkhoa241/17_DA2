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
    public partial class Form10 : Form
    {
        public string connectString;
        public string mk;
        public string manv;
        public string hoten;
        public string mssv;
        public string mahp;
        SqlConnection conn;
        public Form10()
        {
            InitializeComponent();
        }

        private void Form10_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
            string sqlexec1 = "EXEC SP_QLTK";
            SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
            cmd1.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;

        }

       

        private void button2_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form5 f5 = new Form5();
            f5.connectString = connectString;
            this.Close();
            f5.Show();
        }
    }
}

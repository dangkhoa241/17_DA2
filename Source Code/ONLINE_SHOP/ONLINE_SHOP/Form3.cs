using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace ONLINE_SHOP
{
    public partial class Form3 : Form
    {

        public string connectString;
        public string tendn;
        public string mk;
        public string manv;
        public string hoten;
        string mssv;
        SqlConnection conn;
        public Form3()
        {
            InitializeComponent();
            FillCombo();

        }
        private void FillCombo()
        {
            string query = "select distinct TENSANPHAM from dbo.SANPHAM";
            conn = new SqlConnection(@"Data Source=KHOA\SQLEXPRESS;Initial Catalog=ONLINE_SHOP;Integrated Security=True");
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader myReader;
            try
            {
                conn.Open();
                myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                    string PDname = myReader.GetString("TENSANPHAM");
                    comboBox1.Items.Add(PDname);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Form3_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
            label2.Text = tendn;



        }
        private void dataGridView1_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            e.Cancel = true;
        }
        private void button5_Click(object sender, EventArgs e)
        {

            conn.Close();
            Form3 f3 = new Form3();
            f3.connectString = connectString;
            f3.tendn = tendn;
            f3.mk = mk;
            this.Close();
            f3.Show();

        }
        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                mssv = row.Cells[0].Value.ToString();
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

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string tensp = comboBox1.Text;
            string sqlexec1 = "EXEC SP_FIND_SP N'" + tensp + "'";
            SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
            cmd1.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dataGridView1.Columns["MOTA"].Width = 270;
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form5 f5 = new Form5();
            f5.tendn = tendn;
            f5.connectString = connectString;
            f5.Show();
        }

    }
}
